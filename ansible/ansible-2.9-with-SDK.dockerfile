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
RUN apt-get install -y iputils-ping curl wget

# https://pypi.org/
# https://github.com/ansible/ansible/issues/75141
RUN apt-get install -y python3-pip
RUN pip install ansible==2.9.0
RUN pip install ansible-lint==5.2.0
RUN pip install yamllint==1.26.0

# https://pypi.org/project/Jinja2/#history
# https://github.com/sphinx-doc/sphinx/issues/10291
# Else the playbook fails. It is using some old jinja2 functions...
RUN pip install Jinja2==3.0.3

#--------------------------------------
# Install molecule without driver (using delegate driver)
#--------------------------------------
# https://test.pypi.org/project/molecule/#history
# https://stackoverflow.com/questions/63650010/could-not-find-a-version-that-satisfies-the-requirement-pyyaml-5-3-but-pyyaml
# https://github.com/ansible-community/molecule/issues/1641

# In fact if you are using latest version of molecule, it will install repository revel requirements.yml itself without you having to add anything to molecule.yml file.
# You are better of removing dependency block from molecule config.
#
# In fact molecule own logic is smarter than galaxy itself and installs dependencies only when they are missing (galaxy from 2.9 does not support that, not even ability to upgrade them).

RUN pip install --extra-index-url https://test.pypi.org/simple/ molecule==3.4.0


# Configure Ansible
# /etc/ansible/anisble.cfg file is not created by default so we copy in the file :-)
#RUN sed -i '/^\[defaults\]/a display_args_to_stdout = True' /etc/ansible/ansible.cfg
#RUN sed -i '/^\[defaults\]/a callback_whitelist = profile_tasks' /etc/ansible/ansible.cfg
#RUN sed -i '/^\[defaults\]/a host_key_checking = False' /etc/ansible/ansible.cfg
RUN echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc
COPY ansible.cfg /etc/ansible/ansible.cfg


# SSL error when using ansible-galaxy to download roles
# Set MTU for eth0 in WSL
# https://github.com/microsoft/WSL/issues/4698
# Commented out below command due error "#23 0.374 SIOCSIFMTU: Operation not permitted"
# Looks like this configuration is not required anymore...
# RUN ifconfig eth0 mtu 1350


# Configure proxy not required anymore...
# ENV HTTP_PROXY=xxx:8080
# ENV HTTPS_PROXY=xxx:8080
# ENV NO_PROXY=localhost,127.0.0.1,gitlab.ing.net,ansible.ing.net,pypi.org,pythonhosted.org


# Configure git
ENV GIT_SSL_NO_VERIFY=true


# Fix timezone issue
# https://blog.programster.org/docker-ubuntu-20-04-automate-setting-timezone
RUN apt-get install -y tzdata
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /tmp/ansible
