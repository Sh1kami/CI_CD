FROM jenkins/jenkins:lts-jdk21
RUN jenkins-plugin-cli --plugins workflow-aggregator git timestamper
COPY lab08/init.groovy /usr/share/jenkins/ref/init.groovy.d/lab.groovy
COPY lab08/Jenkinsfile /usr/share/jenkins/ref/lab.Jenkinsfile
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
