#https://dev.azure.com/INGCDaaS/IngOne/_build/results?buildId=8097105&view=logs&j=812a7147-c072-5706-4215-ac6360a34f9d&t=c5766e04-c862-5271-94b8-cd459a865c69

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

# https://discuss.python.org/t/getting-requirements-to-build-wheel-did-not-run-successfully-exit-code-1/30365
# https://stackoverflow.com/questions/34645821/pip-constraints-files
RUN echo "Cython<3" > cython_constraint.txt
ENV PIP_CONSTRAINT=cython_constraint.txt



RUN pip install ansible==8.5.0
RUN pip install ansible-lint==5.3.2
# https://github.com/ansible-community/molecule/issues/3498
#RUN pip install ansible-lint==5.4.0
RUN pip install yamllint==1.26.3

# https://pypi.org/project/Jinja2/#history
# https://github.com/sphinx-doc/sphinx/issues/10291
# Else the playbook fails. It is using some old jinja2 functions...
#################RUN pip install Jinja2==3.1.2

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

RUN pip install wheel
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


# Import CA certificate (used in ccp_pwv_interface.yml and ldap_pwv_interface.yml)
# Make sure the CA certificate has .crt extension else update-ca-certificates won't work!!!
# https://blog.confirm.ch/adding-a-new-trusted-certificate-authority/
# https://ubuntu.com/server/docs/security-trust-store
COPY rootg3_b64.crt /usr/local/share/ca-certificates
RUN update-ca-certificates


WORKDIR /tmp/ansible
