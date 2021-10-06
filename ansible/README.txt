https://iceburn.medium.com/run-ansible-with-docker-9eb27d75285b
https://github.com/geerlingguy/docker-ubuntu1604-ansible
https://icicimov.github.io/blog/docker/Building-custom-Docker-images-and-configuring-with-Ansible/	
https://forums.docker.com/t/mount-doesnt-work-with-windows-path/43001
https://forums.docker.com/t/docker-for-windows-wont-launch/15725/12


# Create the image
docker image build -t ansible .
docker image build -f ansible-2.9.dockerfile -t ansible-2.9 .
docker image build -f ansible-2.10.dockerfile -t ansible-2.10 .


# Run the container with an interactive BASH shell
docker container run -v C:/miel/workspace/infra/Ansible:/tmp/ansible -it ansible bash
docker container run -v C:/miel/workspace/infra/Ansible:/tmp/ansible -it ansible-2.9 bash
docker container run -v C:/miel/workspace/infra/Ansible:/tmp/ansible -it ansible-2.10 bash