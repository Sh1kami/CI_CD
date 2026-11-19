# Jenkins
Запускайте з кореня Проєкт. Dockerfile.dockerignore задає окремий контекст.
`docker build -f lab08/Dockerfile -t panchyshkin-jenkins:lab08 .`
`docker run -d --name panchyshkin-jenkins -p 127.0.0.1:8099:8080 -v panchyshkin-jenkins:/var/jenkins_home panchyshkin-jenkins:lab08`
Це ізольований навчальний сервер без автентифікації, доступний лише на localhost.
Не відкривайте його порт у зовнішню мережу. Для постійної роботи налаштуйте
користувача адміністратора та authorization strategy в Manage Jenkins.
Завдання lab08-last-two-commits створюється й запускається один раз.
