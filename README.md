# wodan

A simpler god, less bells, more whistles and two wolves and ravens named
Geri, Freki, Hugin and Munin.

Awesome.

## DSL
```ruby
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
      task.notify    "dba@mydomain.com"  # notify of events
    end

    # and another task
    wodan.task :rails_app do |task|
      task.dir       "/home/rails/app"
      task.daemonize "bundle exec rails server" # wrap and daemonize this cmd
      task.notify    "development@mydomain.com"
    end

    # tell wodan how to deal with the tasks
    wodan.keep_alive(:mysql, :rails_app)
    wodan.start(:some_other)   # just start at wodan start and forget

    wodan.notify('hostmaster@mydomain.com')  # notify of all events
  end
```

## Justification

Either I am too stupid for God, or God has failed in it's intents and purposes.

Everytime I try to setup a functional install of God, it just fails to work for
me.

All I ever wanted is a process monitor that:
  - makes sure processes run
  - keeps those processes within bounds
  - notifies me (or a bunch of people) of significant events 
    (start, stop, restart)


## State

Wodan is not in a production-ready state. In fact, at the moment of writing
this, all I have is the DSL to which I need to write tests and code.

## WTF is Wodan

Wodan is the Germanic/Anglo-saxon counterpart of the (well) known Norge god
Odin.

![Wodan, riding a horse with his wolves and ravens](http://coffeeaddict.github.com/wodan/wodan.jpg)

## Contributing to wodan
 
  - Check out the latest master to make sure the feature has not been
    implemented or the bug hasn't been fixed yet.
  - Check out the issue tracker to make sure someone already hasn't requested
    it and/or contributed it.
  - Fork the project.
  - Start a feature/bugfix branch.
  - Commit and push until you are happy with your contribution.
  - Make sure to add tests for it. This is important so I don't break it in a
    future version unintentionally.
  - Please try not to mess with the Rakefile, version, or history. If you want
    to have your own version, or is otherwise necessary, that is fine, but
    please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Hartog C. de Mik. See LICENSE.txt for
further details.