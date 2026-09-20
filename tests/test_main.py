from unittest.mock import MagicMock

from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_create_monitor(monkeypatch):
    monkeypatch.setattr("app.main.db.put_monitor", MagicMock())
    response = client.post("/monitors", json={"name": "Test", "url": "https://example.com"})
    assert response.status_code == 201
    body = response.json()
    assert body["name"] == "Test"
    assert body["url"] == "https://example.com/"


def test_list_monitors(monkeypatch):
    fake_monitors = [
        {"id": "1", "name": "Test", "url": "https://example.com/", "created_at": "2026-01-01T00:00:00Z"}
    ]
    monkeypatch.setattr("app.main.db.list_monitors", MagicMock(return_value=fake_monitors))
    response = client.get("/monitors")
    assert response.status_code == 200
    assert response.json() == fake_monitors