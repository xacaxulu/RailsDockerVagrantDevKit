[![Build Status](https://travis-ci.org/xacaxulu/RailsDockerVagrantDevKit.svg)](https://travis-ci.org/xacaxulu/RailsDockerVagrantDevKit)

# Download and install [Vagrant](http://vagrantup.com/ "Vagrant") & [VirtualBox](https://www.virtualbox.org/ "VirtualBox") on your laptop.

The main idea here is that you edit your code locally on your host laptop but you execute specs, run database migrations and run servers inside of Vagrant against the Docker container. Vagrant allows us to use Ubuntu as the OS to run the Docker server (as Ubuntu is the main development environment for Docker), to rapidly install and configure a Docker environment, and to share our code via NFS into the Vagrant/Docker environment. Now all the heavy lifting is done on the *exact same Docker image* that you'll containerize in production.

Travis-CI both builds the docker image and container and executes specs against it (see .travis.yml).
After a successful build, Travis can push the image to a repository, making it the canonical build image and can be updated if either the codebase or the Dockerfile is updated.

The other benefit is that everyone can have the exact same development environment via Vagrant while still using their own Text Editors / IDEs and Browsers to develop and test.

# Edit Code Locally => Test/Execute in Vagrant against Docker

###

# Spin up Vagrant Ubuntu box running Docker

from the root of this directory run `vagrant up`

# Apply Chef / Shell directives located in Vagrantfile
``` shell
vagrant provision
```
# login to Ubuntu box that Vagrant has created
``` shell
vagrant ssh
cd /app
```
If you run an `ls` command in ~/app, you'll see that code has been shared via directives in Vagrantfile NFS.


# Build new docker image from Dockerfile named demo
``` shell
docker build -t demo . #where demo is the name of the image you are building.
```

# Start docker container named demo_container from the image named demo
``` shell
docker run -dP --name demo_container -p 3000:3000 demo
```

# See docker container named docker_container is a running docker process
``` shell
docker ps
```

# Setup the DB for running RSpec
``` shell
docker exec app_web_1 bin/rake db:migrate
```

# Run RSpec inside of the container against the DB
``` shell
docker exec app_web_1 bin/bundle exec rspec
```
app_web_1 bin/rake db:migrate RAILS_ENV=development
```
# From your Host computer, you should be able to access the Rails app @ http://localhost:1234/