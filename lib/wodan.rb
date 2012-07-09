require 'wodan/dsl'
require 'wodan/task'
require 'wodan/executor'

module Wodan
  def self.watch(&block)
    yield(Wodan::DSL.new(self))
  end

  def self.tasks
    @tasks ||= []
  end
end