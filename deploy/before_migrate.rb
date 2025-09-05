rails_env = new_resource.environment["RAILS_ENV"]

Chef::Log.info("before migrate hook doing nothing.")

# run "cd #{release_path} && gem install bundler -v 2.2.4"
