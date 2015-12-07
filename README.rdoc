[![Build Status](https://travis-ci.org/xacaxulu/rails_vagrant_docker_dev.svg)](https://travis-ci.org/xacaxulu/rails_vagrant_docker_dev)

# Download and install [Vagrant](http://vagrantup.com/ "Vagrant") & [VirtualBox](https://www.virtualbox.org/ "VirtualBox") on your laptop.

The main idea here is that you edit your code locally on your host laptop but you execute specs/database migrations inside of Vagrant against the Docker container. This is so that all the heavy lifting is done on the exact same Docker image that you'll containerize in production.

Travis-CI both builds the docker image and container and executes specs against it (see .travis.yml).
After a successful build, Travis can push the image to a repository, making it the canonical build image if either the codebase or the Dockerfile is updated.

The other benefit is that everyone can have the exact same development environment via Vagrant while still using their own Text Editors / IDEs and Browsers.

# Edit Code Locally => Test/Execute in Vagrant against Docker

###

# Spin up Vagrant Ubuntu box running Docker

from the root of this directory run `vagrant up`

# Apply Chef / Shell directives located in Vagrantfile
``` shell
vagrant provision
```
# login to Ubuntu box
``` shell
vagrant ssh
cd /vagrant
ls
vagrant@ubuntu-14:/vagrant$ ls
app  CHANGELOG.md  config.ru  docker-compose.yml  Gemfile       lib      log     Rakefile   spec  Vagrantfile
bin  config        db         Dockerfile          Gemfile.lock  LICENSE  public  README.md  tmp   vendor

```
(code has been shared via directives in Vagrantfile NFS)


# Build new docker image from Dockerfile named demo
``` shell
sudo docker build -t demo .
```

# Start docker container named demo_container from the image named demo
``` shell
sudo docker run -dP --name demo_container -p 3000:3000 demo
```

# See docker container named docker_container is a running docker process
``` shell
sudo docker ps
```

# Run RSpec inside of the container
``` shell
sudo docker exec demo_container bin/rake spec
```
# Run migrations for development inside the container
``` shell
sudo docker exec demo_container bin/rake db:migrate RAILS_ENV=development
```
# From your Host computer, you should be able to access the Rails app @ http://localhost:1234/