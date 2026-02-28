FROM klakegg/hugo:ext-alpine AS builder

WORKDIR /src

COPY . .

ARG BASE_URL

RUN hugo \
    --baseURL "${BASE_URL}" \
    --minify \
    --environment production \
    --gc \
    --cleanDestinationDir

FROM ghcr.io/static-web-server/static-web-server:latest

COPY --from=builder /src/public /public

EXPOSE 80
CMD ["--root", "/public"]