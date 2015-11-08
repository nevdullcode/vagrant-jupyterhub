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
* [Git](http://git-scm.com/)
* [VirtualBox](http://www.virtualbox.com)
* [Vagrant](http://www.vagrantup.com)

## Getting Started
After you've installed the required software, open a terminal and execute the
following (this will take some time):

```
sudo vagrant plugin install vagrant-vbguest
git clone http://www.github.com/nevdullcode/vagrant-jupyterhub
cd vagrant-jupyterhub
vagrant up
vagrant reload
```

If everything installed successfully, then you may [visit your JupyterHub!](http://localhost:8000/)

## Usernames and Passwords
**You will want to use the vagrant user account when logging into the JupyterHub WebUI:**

* username: vagrant
* password: vagrant

**For administration:**

* username: root
* password: puppet

## Repackage the VM into a New Vagrant Box (optional)
To prevent having to build the box over and over again when you simply want a fresh JupyterHub VM based on the one created above:

```
vagrant package --output mynew.box
```

The previous command creates a new box file in your CWD. This file can be stored wherever you prefer.

This is how you add the new box file to your Vagrant setup:

```
vagrant box add mynewbox mynew.box
```

The following is an example of how you may decide to base your new project off of the vagrant-jupyterhub built box:

```
mkdir new_project && cd new_project
vagrant init mynewbox
```

Configure your newly generated Vagrantfile for your requirements and then start the VM:

```
vagrant up
```

Visit the following [webpage] (https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one#initialize-your-new-vagrant-box) for more info about this approach.

## What I'm using this for...
I'm using this as a test environment to understand how to install, configure, and maintain JupyterHub on Centos 6.6.

My end goal is to deploy JupyterHub on Clemson University's Palmetto Cluster
such that single user servers will be allowed to run on the cluster compute
nodes by interfacing with the PBS scheduler. I will explore implementing new or
improving existing [JupyterHub Spawners](https://github.com/jupyter/jupyterhub/wiki/Spawners)
and [Jupyter Kernels](https://github.com/ipython/ipython/wiki/IPython-kernels-for-other-languages).
