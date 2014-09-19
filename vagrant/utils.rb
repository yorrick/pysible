# Those apps will be mounted in VM
# returns a Hash(app_name, host_app_path)
def get_dev_apps()
    # PYSIBLE_DEV_APPS=/Users/yorrick/work/django_async
    if ENV.has_key?('PYSIBLE_DEV_APPS')
        apps = ENV['PYSIBLE_DEV_APPS'].split(',').to_set
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


def unpack_app_params(params)
    dns, dir, wsgi_module, venv = params.split(":")
    return {'dns' => dns, 'dir' => dir, 'wsgi_module' => wsgi_module, 'venv' => venv}
end
