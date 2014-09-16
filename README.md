pyansible
=========

Ansible configuration to run multistage python applications


## Run it with vagrant


### Environements

You can change the environement that is run in vagrant with VAGRANT_VAGRANTFILE:
```
export VAGRANT_VAGRANTFILE=vagrant-int
```

You can control which apps are run on a VM by using PYANSIBLE_APPS
```
export PYANSIBLE_APPS=/Users/yorrick/work/django_async
```


Initial setup
```
vagrant up
```

Rebuild everything

```
vagrant halt && vagrant destroy -f && vagrant up
```


Test deployement
```
curl -H 'Host: django-async.local' localhost:8000
```
