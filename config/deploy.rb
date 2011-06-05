set :application, "testapp"
set :repository,  "https://bitbucket.org/dcunited001/#{application}"

#source control configuration
set :scm, :mercurial
set :scm_username, "dcunited001"
set :scm_prefer_prompt, :true



# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ve.p586xn2c.vesrv.com"                          # Your HTTP server, Apache/etc
role :app, "ve.p586xn2c.vesrv.com"                          # This may be the same as your `Web` server
role :db,  "ve.p586xn2c.vesrv.com", :primary => true        # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end