from datetime import datetime, timezone
from uuid import uuid4

from fastapi import FastAPI

from app.models import Monitor, MonitorCreate

app = FastAPI(title="AWS HealthCheck")

# Temporary in-memory store — replaced with DynamoDB in Milestone 4.
_monitors: dict[str, Monitor] = {}


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/monitors", response_model=Monitor, status_code=201)
def create_monitor(payload: MonitorCreate):
    monitor_id = str(uuid4())
    monitor = Monitor(
        id=monitor_id,
        created_at=datetime.now(timezone.utc),
        **payload.model_dump(),
    )
    _monitors[monitor_id] = monitor
    return monitor


@app.get("/monitors")
def list_monitors():
    return list(_monitors.values())