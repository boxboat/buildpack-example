from fastapi.testclient import TestClient

from fastapi_app.health_controller import app


client = TestClient(app)


def test_health_check():
    resp = client.get('/python/health')
    assert resp.status_code == 200
    assert resp.json() == {'status': 'Python Healthy'}