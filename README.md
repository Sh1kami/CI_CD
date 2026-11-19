# CI/CD інструментарій

Автор: Панчишкін Богдан Олександрович, група 3ПРс/3.

Навчальний Python HTTP-сервіс із лічильником PostgreSQL та записом останнього
значення до Redis. Звіти описують перевірки та фактичні обмеження окремо.

## Локальний запуск
Python 3.12: `python -m unittest discover -s tests -v`; `python app.py`.
`http://localhost:3000/health` працює без зовнішніх залежностей.
Для /visits потрібні PostgreSQL, Redis та міграція.

## Лабораторні 1 і 2
`sh lab01/greeting.sh`
`bash lab02/check_files.sh`
Скопіювати lab02/.env.example до lab02/.env; запустити сервіс;
`bash lab02/check_url.sh lab02/.env`.

## Docker
Потрібні Docker Engine із Linux-контейнерами, Compose V2, Bash, Git.
`bash scripts/container_check.sh`
`bash scripts/docker_build_benchmark.sh`
Для CI: `export DB_PASSWORD=local_lab_password`, потім
`bash scripts/docker_compose_ci_runner.sh`.
Скрипт CI зберігає логи й прибирає лише власний Compose-проєкт та його том.
Локально: скопіювати .env.example до .env і виконати `docker compose up --build -d`.
Зупинка локального середовища: `docker compose down`.
Видалення його навчальних даних: `docker compose down --volumes`.

## Ізоляція мереж
db, cache і migrate доступні лише в internal backend. Тести бачать app через
frontend і не мають прямого доступу до бази. Порт 3000 відкривається лише
в локальному override на інтерфейсі 127.0.0.1. CI не підключає цей override.

## Відтворюваність
Версії Python-пакетів зафіксовані. Теги базових Docker-образів можуть змінюватися:
для повністю відтворюваної збірки зафіксуйте RepoDigests із evidence.
OCI image ID незмінний для конкретної збірки, тег можна перепризначити.
Пароль у .env.example демонстраційний, не для публічного сервера.
