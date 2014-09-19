# Those apps will be mounted in VM
# returns a Hash(app_name, host_app_path)
def get_clone_apps()
    # PYSIBLE_CLONE_APPS=/Users/yorrick/work/django_async
    if ENV.has_key?('PYSIBLE_CLONE_APPS')
        apps = ENV['PYSIBLE_CLONE_APPS'].split(',').to_set
        return Hash[apps.map { |host_app_path| [host_app_path.split("/").last, host_app_path] }]
    else
        return {}
    end
end


# Those apps will be deployed on uwsgi / nginx
def get_deploy_apps()
    # PYSIBLE_DEPLOY_APPS=django-async.local:django_async:django_async.wsgi_app_prod:django_async_venv,...
    if ENV.has_key?('PYSIBLE_DEPLOY_APPS')
        apps_params = ENV['PYSIBLE_DEPLOY_APPS'].split(',')
        return apps_params.map { |params| unpack_app_params(params) }
    else
        return nil
    end
end


# Those apps will be undeployed from uwsgi / nginx
def get_undeploy_apps()
    # PYSIBLE_UNDEPLOY_APPS=django-async.local:django_async:django_async.wsgi_app_prod:django_async_venv,...
    if ENV.has_key?('PYSIBLE_UNDEPLOY_APPS')
        return ENV['PYSIBLE_UNDEPLOY_APPS'].split(',')
    else
        return nil
    end
end


def unpack_app_params(params)
    dns, clone_dir, wsgi_module, venv, settings_module = params.split(":")
    return {
        'dns' => dns,
        'clone_dir' => clone_dir,
        'wsgi_module' => wsgi_module,
        'venv' => venv,
        'settings_module' => settings_module,
    }
end
