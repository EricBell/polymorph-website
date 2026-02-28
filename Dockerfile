# ---------- Builder Stage ----------
FROM hugomods/hugo:latest AS builder

WORKDIR /src

# Copy module definition first for caching
COPY go.mod go.sum ./

# This forces module resolution and caches it
RUN hugo mod graph

# Copy the rest of the site
COPY . .

ARG BASE_URL

# Build static site
RUN hugo \
    --baseURL "${BASE_URL}" \
    --minify \
    --environment production \
    --gc \
    --cleanDestinationDir

# ---------- Runtime Stage ----------
FROM ghcr.io/static-web-server/static-web-server:latest

COPY --from=builder /src/public /public

EXPOSE 80

CMD ["--root", "/public"]