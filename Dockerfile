FROM python:3.12-slim

WORKDIR /app

# Install dependencies first, as their own layer — this means Docker only
# re-runs pip install when requirements.txt actually changes, not on every
# code edit. Big rebuild-speed win.
COPY app/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the application code
COPY app/ ./app/

# Run as a non-root user, not root
RUN useradd --create-home --uid 1000 appuser
USER appuser

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]