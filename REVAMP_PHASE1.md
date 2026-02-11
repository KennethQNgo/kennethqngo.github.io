# Phase 1 Revamp Notes

This repository now has a lightweight customization layer for the blog-first revamp.

## Where to customize going forward

- `assets/css/custom.scss`
  - Canonical place for visual overrides and page-specific styling.
  - Keep tokens and shared utility styles at the top of this file.
- `assets/js/custom.js`
  - Canonical place for lightweight interaction and animation behavior.
  - Keep enhancements progressive and dependency-free.

## Scope of this phase

- Home page (`/`)
- Blog index (`/blog/`)
- Post template rendering and typography (`_layouts/post.liquid`)

## Intent

- Improve readability and formatting consistency for writing-heavy pages.
- Keep motion subtle and accessible (`prefers-reduced-motion` respected).
- Minimize conflicts with upstream al-folio theme updates by avoiding heavy template rewrites.
