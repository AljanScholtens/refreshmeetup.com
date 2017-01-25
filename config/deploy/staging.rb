############################################
# Setup Server
############################################

set :stage, :staging
set :stage_url, ''
server 'alpha.studiowolf.com', user: 'refresh', roles: %w{web app db}
set :deploy_to, ''
set :tmp_dir, '/home/refresh/tmp'


############################################
# Setup Git
############################################

set :branch, 'master'
