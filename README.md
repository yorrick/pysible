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
