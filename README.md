# vagrant-jupyterhub
Use Vagrant to provision a [JupyterHub](https://github.com/jupyter/jupyterhub)
server running in a Centos 6.6, VirtualBox VM. Once the build has completed you
may:
* Get busy trying out Jupyter!
* Re-package the VM as a Vagrant box for further customization and/or redistribution.

The JupyterHub hub and proxy run on the single VM. This allows you to
authenticate as the *vagrant* user in order to launch a jupyterhub-singleuser
server which runs a Jupyter Notebook server.

**NOTE**: This project is configured to support single user "servers" that are
run locally, on same VM as the JupyterHub daemons. JupyterHub can be configured
to spawn single user servers in various ways:
* locally (default)
* docker container locally
* docker container remotely via Docker Swarm
* remotely (ssh to a node and then qsub etc.)

## Required Software
You must have the following installed:
* [Git](https://git-scm.com/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com)

## Getting Started
After you've installed the required software, open a terminal and execute the
following (this will take some time):

```
sudo vagrant plugin install vagrant-vbguest
git clone https://www.github.com/nevdullcode/vagrant-jupyterhub
cd vagrant-jupyterhub
./setup-base.sh
vagrant up
```

If everything installed successfully, then you may [visit your JupyterHub!](http://192.168.33.10:8000/)

## Usernames and Passwords
**You will want to use the vagrant user account when logging into the JupyterHub WebUI:**

* username: vagrant
* password: vagrant

**For administration:**
### Note that PAM denies access when logging into JupyterHub as root

* username: root
* password: root

## What I'm using this for...
I'm using this as a test environment to understand how to install, configure, and maintain JupyterHub on Centos 6.6.

My end goal is to deploy JupyterHub on Clemson University's Palmetto Cluster
such that single user servers will be allowed to run on the cluster compute
nodes by interfacing with the PBS scheduler. I will explore implementing new or
improving existing [JupyterHub Spawners](https://github.com/jupyter/jupyterhub/wiki/Spawners)
and [Jupyter Kernels](https://github.com/ipython/ipython/wiki/IPython-kernels-for-other-languages).
