# polymorph-website

Static site for [polymorph.co](https://polymorph.co) built with Hugo. The Polymorph company provides AI testing and stressing services.

## Local Development

### Prerequisites

- [Hugo](https://gohugo.io/installation/) extended edition installed locally
- Git (for submodule init)

### First-time setup

Clone the repo and initialize the theme submodule:

```bash
git clone <repo-url>
cd polymorph-website
git submodule update --init --recursive
```

### Run the dev server

```bash
hugo server --buildDrafts --buildFuture
```

Visit [http://localhost:1313](http://localhost:1313). The server live-reloads on file changes.

- `--buildDrafts` — includes posts with `draft: true`
- `--buildFuture` — includes posts with a future date

### Test a production build locally

```bash
hugo --config hugo.toml --baseURL "https://polymorph.co/" --destination ./public --minify --environment production --cleanDestinationDir
```

Output lands in `./public/`. Open `public/index.html` in a browser or serve it with any static file server.

### Run with Docker (matches production exactly)

```bash
docker-compose up
```

This builds the site using the same Alpine/Hugo container used in production and serves it via Nginx. Visit [http://localhost](http://localhost) (port 80).

## Deployment

Push to the remote repo and trigger a redeploy in Dokploy. The docker-compose build will:

1. Install Hugo on Alpine
2. Initialize git submodules (themes)
3. Build the site into a shared volume
4. Nginx serves the result at https://polymorph.co

## Content

- `content/_index.md` — homepage
- `content/about.md` — about page
- `content/posts/` — blog posts