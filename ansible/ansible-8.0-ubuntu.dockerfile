# https://hub.docker.com/_/ubuntu
FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y sshpass
RUN apt-get install -y git
RUN apt-get install -y dos2unix
RUN apt-get install -y net-tools
RUN apt-get install -y iproute2
RUN apt-get install -y iputils-ping
RUN apt-get install -y curl
RUN apt-get install -y wget


# https://pypi.org/
RUN apt-get install -y python3-pip
RUN pip install ansible==8.0.0
RUN pip install ansible-lint==24.2.0
RUN pip install yamllint==1.35.1
RUN pip install molecule==6.0.3


# Copy ansible.cfg
COPY ansible-8.0.cfg /etc/ansible/ansible.cfg


# Configure Ansible logging
RUN echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc


# Configure git
ENV GIT_SSL_NO_VERIFY=true


# Fix timezone issue
# https://blog.programster.org/docker-ubuntu-20-04-automate-setting-timezone
RUN apt-get install -y tzdata
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata


# Import CA certificate (used in ccp_pwv_interface.yml and ldap_pwv_interface.yml)
# Make sure the CA certificate has .crt extension else update-ca-certificates won't work!!!
# https://blog.confirm.ch/adding-a-new-trusted-certificate-authority/
# https://ubuntu.com/server/docs/security-trust-store
COPY rootg3_b64.crt /usr/local/share/ca-certificates
RUN update-ca-certificates


WORKDIR /tmp/ansible
