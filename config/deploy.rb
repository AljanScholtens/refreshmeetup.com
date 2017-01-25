############################################
# Setup project
############################################

set :application, 'refreshmeetup.com'
set :repo_url, 'git@bitbucket.org:studiowolf/refreshmeetup.com.git'
set :scm, :git

############################################
# Setup Capistrano
############################################

set :log_level, :info
set :use_sudo, false

set :ssh_options, {
  forward_agent: true
}

set :keep_releases, 1


############################################
# Linked files and directories (symlinks)
############################################

set :linked_files, %w{.htaccess}

namespace :deploy do

  desc "create files for symlinking"
  task :create_files do
    on roles(:app) do
      execute :touch, "#{shared_path}/.htaccess"
    end
  end

  after 'check:make_linked_dirs', :create_files


  desc "Creates robots.txt for non-production envs"
  task :create_robots do
    on roles(:app) do
      if fetch(:stage) != :production then

        io = StringIO.new('User-agent: * Disallow: /')
        upload! io, File.join(release_path, "robots.txt")
        execute :chmod, "644 #{release_path}/robots.txt"
      end
    end
  end

  desc "Imports the build assets into the server environment"
  task :push_assets do

    on roles(:web) do

      now = Time.now
      backup_time = [now.year,now.month,now.day,now.hour,now.min,now.sec].join()
      asset_filename = "assets_#{backup_time}.tar.gz"

      puts "Compressing and uploading assets to the server"
      # Create asset tar and build the file
      run_locally do
        execute :gulp, "--type production"
        execute :mkdir, "-p build"
        execute :tar, "-zcvf build/#{asset_filename} dist"
      end

      upload! "build/#{asset_filename}", "#{shared_path}/#{asset_filename}"

      # Extract the assets on the server
      within release_path do
        execute :tar, "-zxvf #{shared_path}/#{asset_filename} -C #{release_path}"
        execute :rm, "#{shared_path}/#{asset_filename}"
      end

      # Remove the tar from the build directory
      run_locally do
        execute :rm, "build/#{asset_filename}"
        if Dir['build/*'].empty?
          execute :rmdir, "build"
        end
      end

      puts "Finished and cleaned up assets"

    end
  end


  desc "Check if changes are pushed and the correct repo is set"
  task :git_check_changes do

    branch = %x(git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/\\1/').chomp
    if branch != fetch(:branch)
      puts "You are not on the #{fetch(:branch)} branch for #{fetch(:stage)} deployment."
      abort
    end

    status = %x(git status --porcelain).chomp
    if status != "" && status !~ %r{^[M ][M ] config/deploy.rb$}
      puts "Your local git repository has uncommitted changes. Commit before deploying."
      abort
    end
  end


  desc "Check if git repositories are aligned"
  task :git_check_repository do

    local_commit = %x(git rev-parse #{fetch(:branch)}).strip
    remote_commit = %x(git rev-parse origin/#{fetch(:branch)}).strip

    if local_commit != remote_commit

      puts "Local 'master' branch is not synchronized with 'origin' repository. Assets can be out of sync if you continue."
      ask(:continue, "Press 'y' to continue anyway")

      if fetch(:continue) != 'y'
        abort
      end

    end

  end

  after :finished, :create_robots
  before :starting, :git_check_changes
  before :starting, :git_check_repository
  after :updating, :push_assets
  after :finishing, "deploy:cleanup"

end
