import json
import os
import urllib.request
base = os.getenv('BASE_URL', 'http://app:3000')
def get(path):
    with urllib.request.urlopen(base + path, timeout=5) as response:
        assert response.status == 200
        return json.load(response)
assert get('/health')['status'] == 'ok'
first = get('/visits')
second = get('/visits')
assert second['visits'] == first['visits'] + 1
assert first['cached'] == first['visits']
assert second['cached'] == second['visits']
print('PASS health, database increment, Redis read/write')
