FROM ubuntu

RUN apt-get update
RUN apt install -y software-properties-common
RUN apt-add-repository --yes --update ppa:ansible/ansible-2.9  # https://stackoverflow.com/questions/50538586/install-specific-version-of-ansible-2-3-1-0-on-ubuntu-18-04-lts
RUN apt install -y ansible
RUN apt install -y ansible-lint
RUN apt install -y vim
RUN apt install -y sshpass
RUN apt install -y git


# Configure Ansible
RUN sed -i '/^\[defaults\]/a display_args_to_stdout = True' /etc/ansible/ansible.cfg
RUN sed -i '/^\[defaults\]/a callback_whitelist = profile_tasks' /etc/ansible/ansible.cfg
RUN sed -i '/^\[defaults\]/a host_key_checking = False' /etc/ansible/ansible.cfg
RUN echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc


# Configure proxy
ENV HTTP_PROXY=xxx
ENV HTTPS_PROXY=xxx
ENV NO_PROXY=localhost,127.0.0.1,gitlab.ing.net,ansible.ing.net
#ENV NO_PROXY=localhost,127.0.0.1,gitlab.ing.net,ansible.ing.net,*.ubuntu.com,launchpad.net,*.launchpad.net  # https://github.com/tmatilai/vagrant-proxyconf/issues/171


# Configure git
ENV GIT_SSL_NO_VERIFY=true


# Fix timezone issue
# https://blog.programster.org/docker-ubuntu-20-04-automate-setting-timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y tzdata
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /tmp/ansible
