FROM klakegg/hugo:ext-alpine AS builder

WORKDIR /src

# install git (required for submodules)
RUN apk add --no-cache git

COPY . .

# initialize theme submodules
RUN git submodule update --init --recursive

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