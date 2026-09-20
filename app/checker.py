import time
from datetime import datetime, timezone

import requests

from app import db

TIMEOUT_SECONDS = 5


def check_monitor(monitor: dict) -> dict:
    url = monitor["url"]
    start = time.monotonic()
    try:
        response = requests.get(url, timeout=TIMEOUT_SECONDS)
        latency_ms = int((time.monotonic() - start) * 1000)
        return {
            "monitor_id": monitor["id"],
            "checked_at": datetime.now(timezone.utc).isoformat(),
            "status": "up" if response.status_code < 400 else "down",
            "status_code": response.status_code,
            "latency_ms": latency_ms,
        }
    except requests.RequestException as exc:
        return {
            "monitor_id": monitor["id"],
            "checked_at": datetime.now(timezone.utc).isoformat(),
            "status": "down",
            "error": str(exc),
        }


def run() -> None:
    monitors = db.list_monitors()
    print(f"Checking {len(monitors)} monitor(s)...")
    for monitor in monitors:
        result = check_monitor(monitor)
        db.put_result(result)
        print(f"  {monitor['name']}: {result['status']} ({result.get('status_code', result.get('error'))})")


if __name__ == "__main__":
    run()