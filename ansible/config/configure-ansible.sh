# Configure Ansible
sed -i '/^\[defaults\]/a display_args_to_stdout = True' /etc/ansible/ansible.cfg
sed -i '/^\[defaults\]/a callback_whitelist = profile_tasks' /etc/ansible/ansible.cfg
sed -i '/^\[defaults\]/a host_key_checking = False' /etc/ansible/ansible.cfg

echo "alias ansible-playbook='ANSIBLE_LOG_PATH=\$(date +%Y%m%d%H%M%S).log ansible-playbook'" >> /root/.bashrc