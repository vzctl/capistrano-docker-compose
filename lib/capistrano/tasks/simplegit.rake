namespace :simplegit do

  desc 'Perform a simple git checkout deploy only and do nothing else'
  task :deploy do
    invoke 'load:defaults'
    on roles :all do
      info "--> Deploy from #{fetch(:simplegit_repo)} on branch #{fetch(:simplegit_branch)}"
      unless test "[ -d #{fetch(:simplegit_deploy)}/.git ]"
        execute "cd #{fetch(:simplegit_deploy)} && git init"
        execute "cd #{fetch(:simplegit_deploy)} && git remote add origin #{fetch(:simplegit_repo)}"
      end

      unless test :git, :'ls-remote', fetch(:repo_url)
        error "Unable to connect to remote repository, check your configuration, and that a valid ssh key exists for remote server."
        exit 1
      end

      within fetch(:simplegit_deploy) do
        execute "cd #{fetch(:simplegit_deploy)} && git fetch"
        if test :git, :'show-branch', fetch(:simplegit_branch)
          execute "git checkout #{fetch(:simplegit_branch)} ; git reset --hard origin/#{fetch(:simplegit_branch)}"
        else
          execute "git checkout -b #{fetch(:simplegit_branch)} origin/#{fetch(:simplegit_branch)}"
        end
        execute "git submodule update --init --recursive"
      end
    end
  end

end

namespace :load do

  task :defaults do
    set :simplegit_deploy, ->   { fetch(:deploy_to) }
    set :simplegit_repo, ->     { fetch(:repo_url) }
    set :simplegit_branch, ->   { fetch(:branch) }

  end

end