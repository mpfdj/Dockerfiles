FROM ubuntu
RUN apt update
RUN apt install -y ansible
RUN apt install -y vim
RUN apt install -y sshpass
RUN apt install -y dos2unix

# Fix timezone issue
# https://blog.programster.org/docker-ubuntu-20-04-automate-setting-timezone
RUN apt install -y tzdata
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

COPY config /etc/ansible
WORKDIR /etc/ansible
RUN dos2unix configure-ansible.sh
RUN ./configure-ansible.sh
WORKDIR /tmp/ansible
