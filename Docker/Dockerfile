FROM alpine:latest

RUN set -xe \
    # Install build tools, libraries and utilities
    && apk add --no-cache --virtual .build-deps \
    gnupg \
    wget \
    # Contain file system pollution
    && TMP="$(mktemp -d)" && cd "$TMP" \
    # Check integrity of the signature by signing the public key
    # retrieved from a key server imported using the key fingerprint
    && gpg --keyserver pgp.mit.edu --recv-keyserver B0F4253373F8F6F510D42178520A9993A1C052F8 \
    # Download, verify and unpack artifacts
    && wget --show-progress http://download/file.tar.gz \
    && wget --show-progress http://download/file.tar.gz.asc \
    && gpg --verify file.tar.gz.asc \
    && tar -xf file.tar.gz \
    # Build and install
    # Clean up
    && cd / && rm -rf "$TMP" \
    && apk del .build-deps \
    # Forward logs to Docker logs cli
    && ln -sf /dev/stdout ...logs/output.log \
    ln -sf /dev/stderr ...logs/error.log

# Copy static content and configuration from host to container
COPY from to

# Stop the container gracefully
STOPSIGNAL SIGQUIT

# Expose port
EXPOSE 1234

# Define entrypoint and default parameters
ENTRYPOINT [""] 
CMD ["",""]
