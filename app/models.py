from datetime import datetime

from pydantic import BaseModel, HttpUrl


class MonitorCreate(BaseModel):
    name: str
    url: HttpUrl


class Monitor(MonitorCreate):
    id: str
    created_at: datetime