# https://hub.docker.com/_/ubuntu

# docker image build --no-cache --file ansible-8.0-ubuntu.dockerfile --tag ansible-8.0-ubuntu .
# docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible_P03881_P17064-BW5_15:/tmp/ansible" -it ansible-8.0-ubuntu /bin/bash

FROM ubuntu
#FROM hackyo/debian:bookworm-slim


# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV GIT_SSL_NO_VERIFY=true


RUN apt update
RUN apt install -y vim
RUN apt install -y sshpass
RUN apt install -y git
RUN apt install -y dos2unix
RUN apt install -y net-tools
RUN apt install -y iproute2
RUN apt install -y iputils-ping
RUN apt install -y curl
RUN apt install -y wget
RUN apt install -y zip
RUN apt install -y man


# https://pypi.org/
RUN apt install -y python3-pip
RUN pip install ansible==8.0.0
RUN pip install ansible-lint==24.2.0
RUN pip install yamllint==1.35.1
RUN pip install molecule==6.0.3


# Copy ansible.cfg
COPY files/ansible/ansible.cfg /etc/ansible/ansible.cfg


# Configure Ansible logging
RUN echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc


# Fix timezone
# https://blog.programster.org/docker-ubuntu-20-04-automate-setting-timezone
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN echo "Europe/Amsterdam" > /etc/timezone


# Import CA certificate (used in ccp_pwv_interface.yml and ldap_pwv_interface.yml)
# Make sure the CA certificate has .crt extension else update-ca-certificates won't work!!!
# https://blog.confirm.ch/adding-a-new-trusted-certificate-authority/
# https://ubuntu.com/server/docs/security-trust-store
COPY files/cacerts/rootg3_b64.crt /usr/local/share/ca-certificates
RUN update-ca-certificates


WORKDIR /tmp/ansible
