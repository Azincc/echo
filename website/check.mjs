import assert from 'node:assert/strict';
import { access, readFile } from 'node:fs/promises';
import { dirname, join, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';
import { normalizeSiteUrl } from './build.mjs';

const root = join(dirname(fileURLToPath(import.meta.url)), 'dist');
const decode = (text) => text.replaceAll('&amp;', '&').replaceAll('&quot;', '"').replaceAll('&#39;', "'");
const attribute = (tag, name) => decode(tag.match(new RegExp(`\\b${name}="([^"]*)"`, 'i'))?.[1] || '');
let base;

for (const [path, language] of [['index.html', 'zh-CN'], ['en/index.html', 'en']]) {
  const html = await readFile(join(root, path), 'utf8');
  assert.equal(attribute(html.match(/<html\b[^>]*>/i)[0], 'lang'), language, `${path}: language`);
  assert.equal((html.match(/<h1\b/g) || []).length, 1, `${path}: one main heading`);
  const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
  assert.equal(ids.length, new Set(ids).size, `${path}: unique IDs`);
  assert.match(html, /<main\b[^>]*\bid="main"[^>]*\btabindex="-1"/, `${path}: skip-link focus target`);
  const canonicalTags = [...html.matchAll(/<link\b[^>]*\brel="canonical"[^>]*>/g)];
  assert.equal(canonicalTags.length, 1, `${path}: one canonical`);
  const canonical = new URL(attribute(canonicalTags[0][0], 'href'));
  if (!base) base = canonical;
  assert.equal(canonical.href, new URL(language === 'en' ? 'en/' : '', base).href, `${path}: canonical route`);
  const alternates = [...html.matchAll(/<link\b[^>]*\bhreflang="[^"]+"[^>]*>/g)].map((match) => match[0]);
  for (const [lang, route] of [['zh-CN', ''], ['en', 'en/'], ['x-default', '']]) {
    const tag = alternates.find((candidate) => attribute(candidate, 'hreflang') === lang);
    assert.ok(tag, `${path}: ${lang} alternate`);
    assert.equal(attribute(tag, 'href'), new URL(route, base).href, `${path}: alternate target`);
  }
  for (const field of ['og:url', 'og:image', 'twitter:image']) {
    const tag = [...html.matchAll(/<meta\b[^>]+>/g)].map((match) => match[0])
      .find((candidate) => attribute(candidate, 'property') === field || attribute(candidate, 'name') === field);
    const url = new URL(attribute(tag || '', 'content'));
    assert.equal(url.origin, base.origin, `${path}: ${field} absolute URL`);
    assert.ok(url.pathname.startsWith(base.pathname), `${path}: ${field} base path`);
  }
  const schema = JSON.parse(html.match(/<script type="application\/ld\+json">([^]*?)<\/script>/)[1]);
  assert.ok(schema['@graph'].some((item) => item['@type'] === 'SoftwareApplication'), `${path}: application schema`);
  assert.ok(schema['@graph'].some((item) => item['@type'] === 'WebPage' && item.url === canonical.href && item.inLanguage === language), `${path}: localized page schema`);
  for (const image of html.matchAll(/<img\b[^>]*>/g)) {
    assert.match(image[0], /\balt="/, `${path}: image alternative text`);
  }
  for (const match of html.matchAll(/\s(?:src|href|data-screenshot)="([^"]+)"/g)) {
    const target = new URL(decode(match[1]), canonical);
    if (target.origin !== base.origin) continue;
    assert.ok(target.pathname.startsWith(base.pathname), `${path}: resource escapes site base: ${match[1]}`);
    const relative = decodeURIComponent(target.pathname.slice(base.pathname.length));
    const filename = resolve(root, relative.endsWith('/') || !relative ? `${relative}index.html` : relative);
    assert.ok(filename.startsWith(root + sep), `${path}: resource escapes output`);
    await access(filename);
    if (target.hash && filename.endsWith('.html')) {
      const linkedHtml = await readFile(filename, 'utf8');
      assert.ok(linkedHtml.includes(`id="${decodeURIComponent(target.hash.slice(1))}"`), `${path}: missing anchor ${match[1]}`);
    }
  }
  const screenshotLinks = [...html.matchAll(/<a\b[^>]*class="[^"]*screenshot-trigger[^>]*>/g)];
  assert.equal(screenshotLinks.length, 5, `${path}: progressive screenshot links`);
  assert.ok(screenshotLinks.every((link) => attribute(link[0], 'href').endsWith('.png')), `${path}: no-JS screenshot destinations`);
  assert.match(html, /hreflang="(?:en|zh-CN)"[^>]*lang="(?:en|zh-CN)"|lang="(?:en|zh-CN)"[^>]*hreflang="(?:en|zh-CN)"/, `${path}: language switch`);
}

const robots = await readFile(join(root, 'robots.txt'), 'utf8');
assert.ok(robots.includes(`Sitemap: ${new URL('sitemap.xml', base).href}`));
const xml = await readFile(join(root, 'sitemap.xml'), 'utf8');
assert.equal((xml.match(/<loc>/g) || []).length, 2, 'Only the two indexable locale pages belong in the sitemap');
assert.equal((xml.match(/xhtml:link/g) || []).length, 6, 'Sitemap alternates must be reciprocal');
assert.match(await readFile(join(root, '404.html'), 'utf8'), /name="robots" content="noindex"/);
const headers = await readFile(join(root, '_headers'), 'utf8');
assert.match(headers, /https:\/\/:project\.pages\.dev\/\*\s+X-Robots-Tag: noindex/);
assert.match(headers, /https:\/\/:version\.:project\.pages\.dev\/\*\s+X-Robots-Tag: noindex/);
const redirects = (await readFile(join(root, '_redirects'), 'utf8')).split('\n')
  .filter((line) => line && !line.startsWith('#'));
assert.deepEqual(redirects, [
  `${base.pathname}index.html ${base.pathname} 301`,
  `${base.pathname}en/index.html ${base.pathname}en/ 301`,
  `${base.pathname}en ${base.pathname}en/ 301`,
], 'Pages canonical redirects must preserve the deployment base and real 404 handling');
const card = await readFile(join(root, 'assets/social-card.png'));
assert.equal(card.readUInt32BE(16), 1200, 'Social image width');
assert.equal(card.readUInt32BE(20), 630, 'Social image height');
assert.equal(normalizeSiteUrl('https://example.com/music').href, 'https://example.com/music/');
for (const invalid of ['ftp://example.com/', 'https://name:secret@example.com/', 'https://example.com/?q=1', 'https://example.com/#en', 'https://example.com/index.html']) {
  assert.throws(() => normalizeSiteUrl(invalid), `Reject invalid deployment URL: ${invalid}`);
}
console.log(`Website checks passed: bilingual HTML, resources, no-JS links, SEO, sitemap, social image and Pages configuration (${base.href}).`);
