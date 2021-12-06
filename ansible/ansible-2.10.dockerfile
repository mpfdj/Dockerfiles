# https://hub.docker.com/_/ubuntu
FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt install -y vim
RUN apt install -y sshpass
RUN apt install -y git

# https://pypi.org/
# https://github.com/ansible/ansible/issues/75141
RUN apt install -y python3-pip
RUN pip install ansible==2.10.0
RUN pip install ansible-lint==5.2.0
RUN pip install yamllint==1.26.0


# Configure Ansible
# /etc/ansible/anisble.cfg file is not created by default so we copy in the file :-)
#RUN sed -i '/^\[defaults\]/a display_args_to_stdout = True' /etc/ansible/ansible.cfg
#RUN sed -i '/^\[defaults\]/a callback_whitelist = profile_tasks' /etc/ansible/ansible.cfg
#RUN sed -i '/^\[defaults\]/a host_key_checking = False' /etc/ansible/ansible.cfg
RUN echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc
COPY ansible.cfg /etc/ansible/ansible.cfg


# Configure proxy
ENV HTTP_PROXY=xxx:8080
ENV HTTPS_PROXY=xxx:8080
ENV NO_PROXY=localhost,127.0.0.1,gitlab.ing.net,ansible.ing.net,pypi.org,pythonhosted.org


# Configure git
ENV GIT_SSL_NO_VERIFY=true


# Fix timezone issue
# https://blog.programster.org/docker-ubuntu-20-04-automate-setting-timezone
RUN apt install -y tzdata
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /tmp/ansible
