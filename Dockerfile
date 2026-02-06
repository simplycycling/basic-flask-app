# Use official uv image
FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim

WORKDIR /app

# Enable bytecode compilation for faster startup
ENV UV_COMPILE_BYTECODE=1

# Copy dependency files
COPY pyproject.toml uv.lock* ./

# Install dependencies
RUN uv sync --frozen --no-dev

# Copy application code
COPY src/ ./src/

ENV FLASK_APP=src/main.py
ENV FLASK_ENV=production
ENV WORKERS=4
ENV TIMEOUT=120

EXPOSE 5000

# Add health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Run with multiple workers, timeout, and access logging
CMD ["sh", "-c", "uv run gunicorn --workers=${WORKERS} --timeout=${TIMEOUT} --bind=0.0.0.0:5000 --access-logfile=- --error-logfile=- src.main:app"] 