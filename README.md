# CI/CD інструментарій — лабораторні роботи 1–11

Автор: Панчишкін Богдан Олександрович, група 3ПРс/3.

Репозиторій містить звіти, вихідний код і конфігурації всіх одинадцяти лабораторних.
Повний комплект опубліковано в гілці **main**.

## Усі лабораторні роботи

У кожній папці є **Звіт.pdf**, редагований **Звіт.md** і **Проєкт_код.zip**.
Журнали виконання збережено в архівах коду відповідних робіт.

| № | Тема | Звіт | Код та матеріали |
| --- | --- | --- | --- |
| 1 | Основи sh і Bash, введення імені та віку | [PDF](laboratories/Лаб%2001/Звіт.pdf) | [Комплект](laboratories/Лаб%2001) · [Код](lab01) |
| 2 | Масиви Bash, властивості файлів, .env і curl | [PDF](laboratories/Лаб%2002/Звіт.pdf) | [Комплект](laboratories/Лаб%2002) · [Код](lab02) |
| 3 | Git: гілки, коміти та злиття | [PDF](laboratories/Лаб%2003/Звіт.pdf) | [Комплект](laboratories/Лаб%2003) · [Історія Git](lab03/lab03-history.bundle) |
| 4 | GitHub: віддалений репозиторій і pull request | [PDF](laboratories/Лаб%2004/Звіт.pdf) | [Комплект](laboratories/Лаб%2004) · [Матеріали](lab04) |
| 5 | GitHub Actions: інформація про ОС і дата при push | [PDF](laboratories/Лаб%2005/Звіт.pdf) | [Комплект](laboratories/Лаб%2005) · [Робочі процеси](lab05) |
| 6 | Android і fastlane: версія, shell-сценарій, release | [PDF](laboratories/Лаб%2006/Звіт.pdf) | [Комплект](laboratories/Лаб%2006) · [Код](lab06) · [APK](laboratories/Лаб%2006/app-release-unsigned.apk) |
| 7 | GitLab: окремий проєкт за наданим завданням | [PDF](laboratories/Лаб%2007/Звіт.pdf) | [Комплект](laboratories/Лаб%2007) · [Матеріали](lab07) |
| 8 | Jenkins: pipeline та два останні коміти | [PDF](laboratories/Лаб%2008/Звіт.pdf) | [Комплект](laboratories/Лаб%2008) · [Jenkinsfile](lab08/Jenkinsfile) |
| 9 | Docker CLI: контейнери, мережі й томи | [PDF](laboratories/Лаб%2009/Звіт.pdf) | [Комплект](laboratories/Лаб%2009) · [Сценарій](scripts/container_check.sh) |
| 10 | Dockerfile: багатоетапна збірка та бенчмарк | [PDF](laboratories/Лаб%2010/Звіт.pdf) | [Комплект](laboratories/Лаб%2010) · [Dockerfile](Dockerfile) · [Бенчмарк](scripts/docker_build_benchmark.sh) |
| 11 | Docker Compose: застосунок, PostgreSQL, Redis, міграція й тести | [PDF](laboratories/Лаб%2011/Звіт.pdf) | [Комплект](laboratories/Лаб%2011) · [Compose](compose.yaml) · [CI-сценарій](scripts/docker_compose_ci_runner.sh) |

## Структура репозиторію

- `laboratories/` — повні комплекти робіт 1–11 зі звітами й архівами коду.
- `reports/` — додаткова копія PDF-звітів і текстів Markdown.
- `lab01/`–`lab08/` — сценарії, конфігурації та матеріали відповідних робіт.
- `app.py`, `migrate.py`, `requirements.txt`, `tests/` — спільний Python HTTP-сервіс із лічильником PostgreSQL і Redis для контейнерних робіт.
- `scripts/`, `Dockerfile`, `Dockerfile.single`, `compose*.yaml` — автоматизація робіт 9–11.

## Результати перевірок

- **1–2:** перевірено введення даних, файлові властивості та HTTP-запит через curl.
- **3:** створено гілку, коміти та злиття; історію збережено в Git bundle.
- **4:** [PR №1](https://github.com/Sh1kami/CI_CD/pull/1) злито в main.
- **5:** додано два робочі процеси GitHub Actions для ручного запуску та події push.
- **6:** fastlane змінив versionCode, виконав greeting і зібрав release APK без підпису.
- **7:** перевірено clone, commit і push до приватного GitLab-проєкту.
- **8:** Jenkins завершив збірку №1 зі статусом SUCCESS і вивів два останні коміти.
- **9:** контейнерна HTTP-перевірка, healthcheck і сім модульних тестів успішні.
- **10:** обидва варіанти збірки успішні; за вимірюванням у звіті multi — 190,55 MiB, single — 203,53 MiB.
- **11:** міграція та інтеграційні перевірки HTTP, PostgreSQL і Redis успішні.

## Локальний запуск
Python 3.12: `python -m unittest discover -s tests -v`; `python app.py`.
`http://localhost:3000/health` працює без зовнішніх залежностей.
Для /visits потрібні PostgreSQL, Redis та міграція.

## Лабораторні 1 і 2
`sh lab01/greeting.sh`
`bash lab02/check_files.sh`
Скопіювати lab02/.env.example до lab02/.env; запустити сервіс;
`bash lab02/check_url.sh lab02/.env`.

## Лабораторні 3–8

- **3:** відновити історію — `git clone lab03/lab03-history.bundle restored-lab03`.
- **4:** поточний комплект доступний у main; історія публікації — у [PR №1](https://github.com/Sh1kami/CI_CD/pull/1).
- **5:** запуск і журнали описано в [lab05/README.md](lab05/README.md).
- **6:** збірка Android і запуск fastlane описані в [lab06/README.md](lab06/README.md). Готовий APK розміщено в комплекті роботи 6. Для встановлення та публікації його потрібно підписати власним ключем.
- **7:** конфігурація й запуск GitLab описані в [lab07/README.md](lab07/README.md).
- **8:** збірка та запуск Jenkins описані в [lab08/README.md](lab08/README.md); адреса — <http://localhost:8099>.

Історію роботи 7 збережено у [Git bundle](lab07/lab07-history.bundle). Її можна відновити без сервера командою `git clone шлях-до-файлу.bundle каталог`.

## Лабораторні 9–11 — Docker
Потрібні Docker Engine із Linux-контейнерами, Compose V2, Bash, Git.
Команди виконуються з кореня клонованого Git-репозиторію; метадані збірки беруться з поточного коміту.

Робота 9 — контейнерна перевірка:

`bash scripts/container_check.sh`

Робота 10 — порівняння збірок і кешу:

`bash scripts/docker_build_benchmark.sh`

Робота 11 — інтеграційний запуск CI: `export DB_PASSWORD=local_lab_password`, потім

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
