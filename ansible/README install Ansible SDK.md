# Install Ansible SDK
https://docs.ansible.com/ansible/2.9/dev_guide/developing_modules_general.html

apt install build-essential libssl-dev libffi-dev python-dev-is-python3 python3.10-venv

cd /opt
git clone https://github.com/ansible/ansible.git
cd /opt/ansible
python3 -m venv venv
pip install -r requirements.txt
. venv/bin/activate
. hacking/env-setup

. venv/bin/activate && . hacking/env-setup


# Create new module
cd /opt/ansible/lib/ansible/modules/
mkdir -p /opt/ansible/lib/ansible/modules/my-modules
touch my_test.py

mkdir /tmp/ansible/my-test
cd /tmp/ansible/my-test

touch args.json
{
    "ANSIBLE_MODULE_ARGS": {
        "name": "hello",
        "new": true
    }
}

python -m ansible.modules.my-modules.my_test /tmp/ansible/my-test/args.json


touch testmod.yml

- name: test my new module
  hosts: localhost
  tasks:
  - name: run the new module
    my_test:
      name: 'hello'
      new: true
    register: testout
  - name: dump test output
    debug:
      msg: '{{ testout }}'


ansible-playbook ./testmod.yml





# Configure vim
https://www.cyberciti.biz/faq/turn-on-or-off-color-syntax-highlighting-in-vi-or-vim/
https://riptutorial.com/vim/example/19205/disable-auto-indent-to-paste-code

# .vimrc
syntax off
set pastetoggle=<F3>



ansible [core 2.14.0.dev0] (devel a01815f3ce) last updated 2022/06/03 12:08:17 (GMT +200)
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/ansible/ansible/lib/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /opt/ansible/ansible/bin/ansible
  python version = 3.10.4 (main, Apr  2 2022, 09:04:19) [GCC 11.2.0] (/opt/ansible/ansible/venv/bin/python)
  jinja version = 3.1.2
  libyaml = True





ansible-galaxy collection init miel.my_collection  