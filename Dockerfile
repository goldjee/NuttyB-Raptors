FROM docker.io/oven/bun:1-alpine AS builder

ENV NEXT_TELEMETRY_DISABLED=1

COPY . /source

# Install git for next.js
RUN apk --no-cache add git

# build
RUN cd /source && \
    bun install && \
    bun run sync -p . && \
    bun test && \
    bun run build

# Create caddy container
FROM docker.io/caddy:2.11-alpine

# Copy caddy config
COPY Caddyfile /etc/caddy/Caddyfile

# Copy files from builder
COPY --from=builder /source/out /srv
