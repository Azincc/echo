import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { extname, resolve, sep } from 'node:path';
import { buildSite } from './build.mjs';

// Preview the same generated files that Pages and the Docker image publish.
const { output: root, siteUrl } = await buildSite();
const basePath = new URL(siteUrl).pathname;
const port = Number(process.env.PORT || 4311);
const types = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.png': 'image/png',
  '.webp': 'image/webp',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain; charset=utf-8',
  '.xml': 'application/xml; charset=utf-8',
};

async function notFound(request, response) {
  const body = await readFile(resolve(root, '404.html'));
  response.writeHead(404, { 'Content-Type': types['.html'], 'Cache-Control': 'no-cache' });
  response.end(request.method === 'HEAD' ? undefined : body);
}

createServer(async (request, response) => {
  try {
    if (!['GET', 'HEAD'].includes(request.method)) {
      response.writeHead(405, { Allow: 'GET, HEAD' }).end();
      return;
    }
    const url = new URL(request.url, 'http://localhost');
    let pathname = decodeURIComponent(url.pathname);
    const mounted = basePath !== '/' && pathname.startsWith(basePath);
    if (mounted) pathname = '/' + pathname.slice(basePath.length);
    const prefix = mounted ? basePath.replace(/\/$/, '') : '';
    const redirects = { '/en': '/en/', '/en/index.html': '/en/', '/index.html': '/' };
    if (redirects[pathname]) {
      response.writeHead(301, { Location: prefix + redirects[pathname] + url.search }).end();
      return;
    }
    const target = resolve(root, `.${pathname.endsWith('/') ? pathname + 'index.html' : pathname}`);
    if (!target.startsWith(root + sep) || !types[extname(target)]) {
      await notFound(request, response);
      return;
    }
    const body = await readFile(target);
    response.writeHead(200, {
      'Content-Type': types[extname(target)],
      'Content-Length': body.length,
      'Cache-Control': 'no-cache',
    });
    response.end(request.method === 'HEAD' ? undefined : body);
  } catch (error) {
    if (['ENOENT', 'EISDIR'].includes(error.code)) await notFound(request, response);
    else response.writeHead(error instanceof URIError ? 400 : 500).end('Unable to load resource');
  }
}).listen(port, '127.0.0.1', () => {
  console.log(`Echoes website: http://localhost:${port}`);
  console.log('English: /en/ — source edits require running node website/build.mjs again.');
});
