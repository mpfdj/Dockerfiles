https://iceburn.medium.com/run-ansible-with-docker-9eb27d75285b
https://github.com/geerlingguy/docker-ubuntu1604-ansible
https://icicimov.github.io/blog/docker/Building-custom-Docker-images-and-configuring-with-Ansible/	
https://forums.docker.com/t/mount-doesnt-work-with-windows-path/43001


# Create the image
docker image build -t ansible .

# Run the container with an interactive BASH shell
docker container run -v C:/miel/workspace/infra/Ansible:/tmp/ansible -it ansible bash

