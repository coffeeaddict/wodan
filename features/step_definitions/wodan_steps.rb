Given /^a running daemon: (\w+)$/ do |name|
  @daemon = DaemonSimulator.new(name)
  @daemon.start
end

When /^I start a task for: (\w+)$/ do |name|
  Wodan.watch do |wodan|
    wodan.task(name) do |task|
      task.pid_file = @daemon.pid_file
      task.log_file = @daemon.log_file
      task.start    = "/usr/bin/ls"
    end

    wodan.start(name)
  end
end

Then /^'(\w+)' should still be running$/ do |name|
  @daemon.should be_running
end

Then /^wodan should say '(\w+)' is '(\w+)'$/ do |name, status|
  pending # express the regexp above with the code you wish you had
end
