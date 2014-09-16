# adds sync folders to given VM
def sync_folders(vm)
    if ENV.has_key?('PYANSIBLE_APPS')
        apps = ENV['PYANSIBLE_APPS'].split(',').to_set
        apps.each do |host_app_path|
            app_name = host_app_path.split("/").last
            # vm.synced_folder host_app_path, "/srv/app/#{app_name}", :owner=> 'webapp', :group=>'webapp', :mount_options => ['dmode=777', 'fmode=777']
            vm.synced_folder host_app_path, "/srv/app/#{app_name}", :mount_options => ['dmode=777', 'fmode=777']
        end
    end
end
