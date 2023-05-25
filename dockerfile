FROM jenkins/jenkins:latest
USER root

RUN apt update && \
    apt install apt-transport-https ca-certificates curl software-properties-common unzip -y

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt install docker.io -y

RUN curl -fsSL -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
RUN unzip /tmp/terraform.zip -d /usr/local/bin 
RUN rm /tmp/terraform.zip