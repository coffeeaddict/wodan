# wodan

A simpler god, less bells, more whistles

## DSL

  # let wodan watch
  Wodan.watch do |wodan|
    # a task
    wodan.task :mysql do |task|
      task.pid_file "/var/run/mysqld/mysqld.pid"
      task.log_file "/var/log/mysql.log"
      task.start    "service mysql start"
      task.stop     "service mysql stop"
      task.restart  "service mysql restart"
      task.limits   {
        :memory => 100  # megabytes
        :cpu    => 75   # percent
      }
      task.notify    "dba@mydomain.com"  # notify off events
    end

    # and another task
    wodan.task :rails_app do |task|
      task.dir     "/home/rails/app"
      task.start   "bundle exec rails server"
      task.notify  "development@mydomain.com"
    end

    # tell wodan how to deal with the tasks
    wodan.keep_alive(:mysql, :rails_app)
    wodan.start(:some_other)   # just start at wodan start and forget

    wodan.notify('hostmaster@mydomain.com')  # notify off all events
  end