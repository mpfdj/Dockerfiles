# https://pythonspeed.com/articles/centos-8-is-dead/
# https://hub.docker.com/u/redhat

# docker image build --no-cache -f ansible-8.0-redhat-ubi.dockerfile -t ansible-8-redhat-ubi .
# docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible_P03881_P17064-BW5_15:/tmp/ansible" -it ansible-8-redhat-ubi /bin/bash
# docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible_P03881_P17064-BW5_15:/tmp/ansible" -dit ansible-8-redhat-ubi /usr/sbin/init
# docker exec -it <CONTAINER ID> /bin/bash

FROM redhat/ubi8

ARG SUBSCRIPTION_MANAGER_USERNAME=""
ARG SUBSCRIPTION_MANAGER_PASSWORD=""


RUN yum install -y vim
RUN yum install -y sshpass
RUN yum install -y git
RUN yum install -y dos2unix
RUN yum install -y net-tools
RUN yum install -y iputils
RUN yum install -y wget
RUN yum install -y procps-ng
RUN yum install -y man

RUN yum install -y python3.11-pip
RUN pip3 install ansible==8.0.0
RUN pip3 install ansible-lint==24.2.0
RUN pip3 install yamllint==1.35.1
RUN pip3 install molecule==6.0.3
COPY ansible-8.0.cfg /etc/ansible/ansible.cfg


RUN echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc
RUN echo "alias ll='ls -lha --color'" >> /root/.bashrc


# https://www.redhat.com/sysadmin/configure-ca-trust-list
COPY rootg3_b64.crt /etc/pki/ca-trust/source/whitelist
RUN update-ca-trust


RUN subscription-manager register --username ${SUBSCRIPTION_MANAGER_USERNAME} --password ${SUBSCRIPTION_MANAGER_PASSWORD} --name ansible-8.0-redhat-ubi
RUN subscription-manager refresh

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf upgrade -y

COPY squashfs-tools-4.3-25.fc32.x86_64.rpm /tmp
RUN yum localinstall -y /tmp/squashfs-tools-4.3-25.fc32.x86_64.rpm
RUN yum install -y udev
RUN yum install -y snapd
RUN systemctl enable snapd.socket
RUN ln -s /var/lib/snapd/snap /snap

# First run Docker image with /usr/sbin/init. Then run snap command, install udev again when you encounter the following error "error: too early for operation, device not yet seeded or device model not acknowledged".
#snap install hello-world



WORKDIR /tmp/ansible





# RedHat subscription-manager
# https://access.redhat.com/discussions/4603661?tour=8
# https://access.redhat.com/solutions/4532901


# Install hello-world using snap
# https://snapcraft.io/install/my-hello-world-app/rhel
# https://snapcraft.io/install/hello-world/centos


# Install hello-world snap application offline
# https://forum.snapcraft.io/t/offline-snap-installers-and-possibility-to-update/275

#Yeah, try this:
#
# snap download hello-world
# snap ack hello-world_27.assert
# snap install hello-world_27.snap
# snap list





# squashfs-tools ChaptGPT
# The latest version of squashfs-tools that supports glibc 2.28 is version 4.4
# ldd --version


# squashfs-tools Fedora
# https://src.fedoraproject.org/rpms/squashfs-tools
# https://rpms.remirepo.net/rpmphp/
# https://koji.fedoraproject.org/koji/index   (Fedora buildsystem)
# wget https://kojipkgs.fedoraproject.org//vol/fedora_koji_archive03/packages/squashfs-tools/4.3/25.fc32/x86_64/squashfs-tools-4.3-25.fc32.x86_64.rpm


# Install squahsfs-tools using Makefile
# https://github.com/plougher/squashfs-tools

# Start Docker container with systemd
# https://stackoverflow.com/questions/59466250/docker-system-has-not-been-booted-with-systemd-as-init-system