module Wodan
  class Executor
    # Just do it
    #
    # @param [Symbol,String] cmd The command to perform
    # @param [Wodan::Task] task The task to perform the command on
    def self.execute(cmd, task)
      self.new.send(cmd, task)
    end

    def start(task)
      if task.start?
        if task.pid_file? && File.exists?(task.pid_file)
          $stderr.puts "#{task.name} is already running"
          return
        end

        $stderr.puts "Starting #{task.name} :)"
        pid = Process.fork do
          Process.uid = task.uid if task.uid?
          Process.gid = task.gid if task.gid?

          list = task.start
          list.unshift task.env if task.env?
          list.push *task.arguments

          Process.exec list
        end

        Process.wait(pid)
      end
    end
  end
end