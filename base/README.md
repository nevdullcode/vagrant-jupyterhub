# Sets up a base image with updated packages, Python 3, and Jupyter+JupyterHub
## Note this base image will not have JupyterHub configured and running, only
# installed.
```
vagrant up && \
vagrant reload && \
vagrant halt && \
vagrant package --output mybase.box && \
vagrant box add mybase mybase.box && \
rm -f mybase.box
```
