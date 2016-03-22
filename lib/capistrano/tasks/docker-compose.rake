namespace :docker_compose do

  desc 'Perform a git checkout deploy, then build & (re)start through docker-compose'
  task :deploy do
    invoke 'simplegit:deploy'
    invoke 'load:defaults'
    invoke 'docker_compose:prepare_environment'
    invoke 'docker_compose:deploy:run_steps'
  end

  task :prepare_environment do
    env = {}

    fetch(:docker_pass_env).each do |env_key|
      env[env_key] = ENV[env_key]
    end

    SSHKit.config.default_env.merge! env
  end
end

namespace :load do
  task :defaults do
    set :docker_role,                 -> { :web }
    set :docker_pass_env,             -> { [] }

    set :docker_compose_project_name,       -> { nil }
    set :docker_compose_remove_after_stop,  -> { true }
    set :docker_compose_remove_volumes,     -> { true }
    set :docker_compose_build_services,     -> { nil }
  end
end