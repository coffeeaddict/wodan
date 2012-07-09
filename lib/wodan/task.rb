module Wodan
  # Hold a task
  class Task

    # Extend attr_accessor so that next to a getter and setter, we also have
    # a ? method which checks if the attribute is filled and not nil
    #
    #   attr_accessor :foo # => foo(), foo=(val), foo?()
    #
    # @param [Symbol] args the list of attributes
    def self.attr_accessor(*args)
      super
      args.each do |arg|
        instance_eval do
          define_method :"#{arg}?" do
            var = instance_variable_get("@#{arg}")

            !var.nil? &&
            (var.respond_to?(:empty) ? !var.empty? : true)
            (var.respond_to?(:blank) ? !var.blank? : true)
          end
        end
      end
    end

    attr_accessor :pid_file, :log_file, :daemonize, :start, :stop, :restart,
      :limits, :name, :uid, :gid

    # @param [String] name of the task
    def initialize(name)
      @name = name
    end
  end
end