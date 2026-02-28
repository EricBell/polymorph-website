# ---------- Builder Stage ----------
FROM hugomods/hugo:latest AS builder

WORKDIR /src

# Copy only module files first (dependency layer caching)
COPY go.mod go.sum ./

# Download Hugo modules (theme, etc.)
RUN hugo mod download

# Now copy the rest of the site
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

# Copy built site from builder
COPY --from=builder /src/public /public

EXPOSE 80

CMD ["--root", "/public"]