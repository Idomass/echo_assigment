FROM redis:7-alpine

# Pre-chown the data dir at build time (entrypoint normally does this at runtime)
RUN mkdir -p /data && chown -R redis:redis /data

# Make the entrypoint's root-only branch unreachable, then delete the binary
RUN rm -f /usr/local/bin/gosu

USER redis
