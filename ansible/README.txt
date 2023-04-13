https://iceburn.medium.com/run-ansible-with-docker-9eb27d75285b
https://github.com/geerlingguy/docker-ubuntu1604-ansible
https://icicimov.github.io/blog/docker/Building-custom-Docker-images-and-configuring-with-Ansible/	
https://forums.docker.com/t/mount-doesnt-work-with-windows-path/43001
https://forums.docker.com/t/docker-for-windows-wont-launch/15725/12


# Create the image
docker image build --no-cache --file ansible-2.9.dockerfile --tag ansible-2.9 .
docker image build --no-cache --file ansible-2.10.dockerfile --tag ansible-2.10 .
docker image build --no-cache --file ansible-2.10-using-apt-instead-of-pip.dockerfile --tag ansible-2.10-apt .


# Run the container with an interactive BASH shell
docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible:/tmp/ansible" --interactive --tty ansible-2.9 bash
docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible_P03881:/tmp/ansible" --interactive --tty ansible-2.9 bash
docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible_P17064-BW5_15:/tmp/ansible" --interactive --tty ansible-2.9 bash

docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible:/tmp/ansible" --interactive --tty ansible-2.10 bash
docker container run --rm --privileged --volume "C:\Users\TO11RC\OneDrive - ING\miel\workspace\Ansible:/tmp/ansible" --interactive --tty ansible-2.10-apt bash


# Remove all docker images
docker rmi -f $(docker images -a -q)

# ----------------------------------------------
# Some useful commands on Ubuntu repositories
# ----------------------------------------------

# List remote repositories
apt-get install devscripts
rmadison yamllint

# List available versions
# https://linoxide.com/install-specific-version-package-apt-get/
apt-cache madison yamllint
apt-cache policy yamllint

# List distro information
lsb_release -a

# Add a repository
add-apt-repository universe
apt-get update

# Add a repository on ubuntu
# https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/
touch /etc/apt/sources.list.d/focal.list
deb http://archive.ubuntu.com/ubuntu/ focal universe

touch /etc/apt/sources.list.d/impish.list
deb http://archive.ubuntu.com/ubuntu/ impish universe

apt-get update
apt-cache madison yamllint

# Install a version
# https://askubuntu.com/questions/138284/how-to-downgrade-a-package-via-apt-get
apt install yamllint=1.20.0-1
apt install yamllint=1.26.0-2





pip install ansible==2.10.0
pip install ansible-lint==5.0.0
pip install yamllint==1.26.0


# Howto install a pip module using tar
# https://www.geeksforgeeks.org/how-to-install-jmespath-terminal-on-linux/



# Adding a new trusted certificate authority
https://blog.confirm.ch/adding-a-new-trusted-certificate-authority/
https://ubuntu.com/server/docs/security-trust-store

apt-get install -y ca-certificates
mv rootg3_b64.cer rootg3_b64.crt
cp rootg3_b64.crt /usr/local/share/ca-certificates
update-ca-certificates