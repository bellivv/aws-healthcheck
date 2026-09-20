
from datetime import datetime, timezone
from uuid import uuid4

from fastapi import FastAPI

from app import db
from app.models import Monitor, MonitorCreate

app = FastAPI(title="AWS HealthCheck")


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/monitors", response_model=Monitor, status_code=201)
def create_monitor(payload: MonitorCreate):
    monitor = Monitor(
        id=str(uuid4()),
        created_at=datetime.now(timezone.utc),
        **payload.model_dump(),
    )
    db.put_monitor(monitor.model_dump(mode="json"))
    return monitor


@app.get("/monitors")
def list_monitors():
    return db.list_monitors()# CD pipeline test
