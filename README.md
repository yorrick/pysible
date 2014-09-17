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


## Development


### Benefits
1. Dev env is as close as possible as the production env
2. Can easily distribute copies of dev env, it takes no time to setup a new dev machine, or to update the dev envs.
3. No more problems installing python packages on windows, evrything is the same whatever the os you use on your dev machine
4. You do not polute your host machine with a lot a dependencies

### Drawbacks
1. One person has to maintain the env
2. Run a VM on your dev machine: it takes memory
3. You have to be a bit comfortable using the shell
4. You have to install ansible on your dev machine, which is not blazing fast on windows hosts (or we could just distribute prebuilt vagrant images)


### Restore database

Using vagrant user
```
sudo su postgres -c 'psql -f /vagrant/dbdump postgres'
```


### Run django devserver

1. App is located at /srv/app/<app> directory
2. Virtualenv for app is located at /srv/virtualenv/<app>
3. Run devserver on 0.0.0.0:8000 so it is accessible on host machine (not only in local)
4. You have to use the development settings

```
vagrant ssh
cd /srv/app/django_async/
source /srv/virtualenv/django_async/bin/activate
./manage.py runserver 0.0.0.0:8000 --settings=django_async.settings_dev
```

Application is now accessible at http://localhost:8000 from the host!

You can configure your editor on your machine and edit the files, app will be reloaded automatically, as if you were working on local machine.


NB: to use an editor that uses the project's virtualenv, see if your editor supports remote virtualenvs (like pycharm)



## Integration

### Make a database backup

Using vagrant user
```
sudo su postgres -c 'pg_dumpall > /tmp/dbdump' && cp /tmp/dbdump /vagrant/
```

Test deployment
```
curl localhost:18000
curl -H 'Host: django-async.local' localhost:18000/en/
```
