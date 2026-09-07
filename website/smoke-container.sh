#!/usr/bin/env bash
set -euo pipefail

image="${1:-echoes-website:smoke}"
container_id=''

cleanup() {
  local status=$?
  trap - EXIT
  if [[ -n "$container_id" ]]; then
    if [[ "$status" -ne 0 ]]; then
      docker logs "$container_id" >&2 || true
    fi
    docker rm -f "$container_id" >/dev/null 2>&1 || true
  fi
  exit "$status"
}
trap cleanup EXIT

# Match the production Compose restrictions while choosing an available local port.
container_id=$(docker run --detach \
  --read-only \
  --tmpfs /tmp:rw,noexec,nosuid,size=16m \
  --cap-drop ALL \
  --security-opt no-new-privileges:true \
  --publish 127.0.0.1::8080 \
  "$image")

container_user=$(docker inspect --format '{{.Config.User}}' "$container_id")
if [[ "$container_user" != '101:101' ]]; then
  echo "Expected non-root container user 101:101; received: $container_user" >&2
  exit 1
fi

base_url="http://$(docker port "$container_id" 8080/tcp)"
health=$(curl --fail --silent --show-error --retry 15 --retry-connrefused \
  --retry-delay 1 --retry-max-time 30 --max-time 3 "$base_url/healthz")
if [[ "$health" != 'ok' ]]; then
  echo 'The container health endpoint did not return ok.' >&2
  exit 1
fi

assert_status() {
  local path="$1" expected="$2" actual
  actual=$(curl --silent --show-error --max-time 5 --output /dev/null \
    --write-out '%{http_code}' "$base_url$path")
  if [[ "$actual" != "$expected" ]]; then
    echo "Expected HTTP $expected for $path; received HTTP $actual." >&2
    exit 1
  fi
}

assert_redirect() {
  local path="$1" destination="$2" actual
  assert_status "$path" 301
  actual=$(curl --silent --show-error --max-time 5 --output /dev/null \
    --write-out '%{redirect_url}' "$base_url$path")
  if [[ "$actual" != "$base_url$destination" ]]; then
    echo "Expected $path to redirect to $destination; received: $actual" >&2
    exit 1
  fi
}

assert_status / 200
assert_status /en/ 200
assert_status /__missing_container_smoke__ 404
assert_redirect /en /en/
assert_redirect /index.html /
assert_redirect /en/index.html /en/

echo 'Container smoke checks passed: non-root/read-only startup, health, both languages, redirects, and HTTP 404.'
