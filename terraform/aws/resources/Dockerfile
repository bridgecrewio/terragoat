FROM python:3.7-slim
RUN useradd -m appuser
USER appuser
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD python -c "import sys; sys.exit(0)"
