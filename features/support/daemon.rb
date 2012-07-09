require 'tempfile'

# A daemon simulator
#
class DaemonSimulator
  attr_reader :pid, :pid_file, :log_file, :name

  def initialize(name)
    @name = name
  end
  
  def start
    @pid_file = Tempfile.new(@name)
    @log_file = Tempfile.new(@name)
    
    th = Thread.new(@log_file, @pid_file) { |lf, pf|
      pid = Process.fork do
        Signal.trap("HUP") do
          lf.close
          pf.close

          $stderr.puts "Reaped!"; exit
        end

        # i am a sleepy daemon
        sleepy = 0.5
        while(true)
          sleep sleepy += 0.2
          lf.puts "slept for a while"
        end
      end

      th[:pid] = pid
      pf.puts pid

      Process.wait
    }
  
    while th[:pid].nil?
      # wait for the fork to happen
      sleep 0.2
    end
  
    @pid = th[:pid]
    at_exit {
      Process.kill("HUP", @pid)
    }
  end
  
  def stop
    Process.kill("HUP", @pid)
    @pid = nil
  end
  
  def restart
    stop
    start
  end
  
  def running?
    !@pid.nil? && !@pid_file.nil? && @pid_file.rewind && @pid_file.read == "#{@pid}\n"
  end
end