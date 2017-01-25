############################################
# Setup Server
############################################

set :stage, :production
set :stage_url, ''
server 'alpha.studiowolf.com', user: 'refresh', roles: %w{web app db}
set :deploy_to, '/home/refresh/domains/refreshmeetup.com/public_html'
set :tmp_dir, '/home/refresh/tmp'


############################################
# Setup Git
############################################

set :branch, 'master'
