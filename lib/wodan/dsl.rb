module Wodan
  # @attr_reader wodan
  class DSL
    attr_reader :wodan
    def initialize(wodan)
      @wodan = wodan
    end

    # A task to monitor
    #
    # @param [Symbol,String] the alias for the task
    def task(name, &block)
      task = Wodan::Task.new(name)
      yield(task)
      wodan.tasks << task
    end

    def start(*names)
      names.each do |name|
        wodan.tasks.select { |t| t.name == name }.each do |task|
          Wodan::Executor.execute(:start, task)
        end
      end
    end

    def keep_alive(*names)
      names.each do |name|
        wodan.tasks.select { |t| t.name == name }.each do |task|
          Wodan::Executor.execute(:keep_alive, task)
        end
      end
    end
  end
end