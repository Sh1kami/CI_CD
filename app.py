"""Навчальний лічильник відвідувань. Автор: Панчишкін Богдан, 3ПРс/3."""
import json
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

def greeting(name, age):
    if not isinstance(age, int) or isinstance(age, bool) or not 0 <= age <= 150:
        raise ValueError('age must be an integer between 0 and 150')
    if not isinstance(name, str) or not name.strip():
        raise ValueError('name must not be empty')
    return f'Привіт {name}, через рік тобі буде {age + 1} років!'

def database():
    import psycopg
    return psycopg.connect(os.environ['DATABASE_URL'], connect_timeout=3)

def cache():
    import redis
    return redis.Redis.from_url(os.environ['REDIS_URL'], socket_connect_timeout=3, socket_timeout=3)

class Handler(BaseHTTPRequestHandler):
    def reply(self, status, data):
        body = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        try:
            if self.path == '/health':
                if os.getenv('DATABASE_URL'):
                    with database() as db:
                        db.execute('SELECT 1').fetchone()
                    cache().ping()
                self.reply(200, {'status': 'ok', 'author': 'Панчишкін Богдан Олександрович'})
            elif self.path == '/visits':
                with database() as db:
                    count = db.execute('UPDATE counter SET value=value+1 WHERE id=1 RETURNING value').fetchone()[0]
                cache().set('last_visit', count)
                self.reply(200, {'visits': count, 'cached': int(cache().get('last_visit'))})
            elif self.path == '/':
                self.reply(200, {'project': 'cicd-labs', 'group': '3ПРс/3'})
            else:
                self.reply(404, {'error': 'not found'})
        except Exception:
            self.reply(503, {'error': 'dependency unavailable'})

if __name__ == '__main__':
    ThreadingHTTPServer(('0.0.0.0', int(os.getenv('APP_PORT', '3000'))), Handler).serve_forever()
