require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" =&gt; :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" =&gt; "resque:work"
