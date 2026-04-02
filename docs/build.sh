#!/bin/bash
# Build documentation HTML pages from Markdown files
# Uses 'marked' npm package for reliable markdown→HTML conversion

DOCS_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$DOCS_DIR")"

# Install marked if not present
if [ ! -d "$ROOT_DIR/node_modules/marked" ]; then
  echo "Installing marked..."
  cd "$ROOT_DIR" && npm install --save-dev marked > /dev/null 2>&1
fi

for md in "$DOCS_DIR"/*.md; do
  name=$(basename "$md" .md)
  html_file="$DOCS_DIR/$name.html"

  echo "Building $name.html..."

  # Convert markdown to HTML using marked
  node -e "
    const fs = require('fs');
    const { marked } = require('$ROOT_DIR/node_modules/marked');

    const md = fs.readFileSync('$md', 'utf8');
    const content = marked.parse(md);

    // Sidebar with active page
    const pages = [
      { href: 'index.html', label: 'Home', section: null },
      { href: 'custom-fields.html', label: 'Custom Fields', section: 'Guides' },
      { href: 'responsive.html', label: 'Responsive Design', section: 'Guides' },
      { href: 'api-reference.html', label: 'API Reference', section: 'Reference' },
      { href: 'changelog.html', label: 'Changelog', section: 'Reference' },
    ];

    let sidebarHtml = '';
    let currentSection = null;
    for (const p of pages) {
      if (p.section && p.section !== currentSection) {
        sidebarHtml += '<div class=\"section-title\">' + p.section + '</div>';
        currentSection = p.section;
      }
      const active = p.href === '$name.html' ? ' class=\"active\"' : '';
      sidebarHtml += '<a href=\"' + p.href + '\"' + active + '>' + p.label + '</a>';
    }

    const html = '<!DOCTYPE html>' +
'<html lang=\"en\">' +
'<head>' +
'  <meta charset=\"UTF-8\">' +
'  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">' +
'  <title>$name — Booking System Documentation</title>' +
'  <link rel=\"stylesheet\" href=\"style.css\">' +
'</head>' +
'<body>' +
'<button class=\"menu-toggle\" onclick=\"document.querySelector(\\'.sidebar\\').classList.toggle(\\'open\\')\">&#9776;</button>' +
'<div class=\"layout\">' +
'  <aside class=\"sidebar\">' +
'    <div class=\"sidebar-logo\">Booking System<small>Documentation V1.1</small></div>' +
'    <nav>' + sidebarHtml + '</nav>' +
'  </aside>' +
'  <main class=\"main\"><div class=\"content\">' +
content +
'  </div></main>' +
'</div>' +
'</body></html>';

    fs.writeFileSync('$html_file', html);
  "
done

echo "Done! Built $(ls "$DOCS_DIR"/*.html | wc -l) pages."
