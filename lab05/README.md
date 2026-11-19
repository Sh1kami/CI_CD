# Android і fastlane
Збірка інструментів із кореня Проєкт:
`docker build -f lab05/Dockerfile -t panchyshkin-fastlane:lab05 .`
Файл lab05/Dockerfile.dockerignore окремо дозволяє Gemfile у контексті збірки.
Запуск із монтуванням кореня Проєкт до /workspace:
`docker run --rm -v "$PWD:/workspace" -w /workspace/lab05 panchyshkin-fastlane:lab05 bundle exec fastlane bump`
Аналогічно lanes greeting і release. /opt/gradle/bin/gradle доступний у Docker.
Для локального Android Studio змініть gradle_path у Fastfile на свій Gradle.
APK: app/build/outputs/apk/release/app-release-unsigned.apk.
Release APK не підписаний. Для встановлення й публікації потрібен власний
keystore; секретні ключі до навчального архіву не додаються.
