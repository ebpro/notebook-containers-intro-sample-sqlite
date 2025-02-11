# Use specific Alpine version for better reproducibility
FROM alpine:3.19

# Add metadata
LABEL maintainer="emmanuel.bruno@univ-tln.fr"
LABEL description="SQLite container for data exploration"
LABEL version="1.0"

# Create non-root user
RUN addgroup -S sqlite && \
    adduser -S sqlite -G sqlite

# Install SQLite and cleanup
RUN apk add --no-cache sqlite

# Set up working directory and volume
VOLUME /workdir
WORKDIR /workdir
RUN chown -R sqlite:sqlite /workdir

# Switch to non-root user
USER sqlite

# Set up entrypoint and default command
ENTRYPOINT ["sqlite3", "-box", "local.db"]
CMD ["--version"]