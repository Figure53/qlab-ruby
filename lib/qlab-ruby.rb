require "qlab-ruby/version"
require "qlab-ruby/core-ext/osc-ruby"

module QLab
  autoload :Commands, 'qlab-ruby/commands'
  autoload :Communicator, 'qlab-ruby/communicator'
  autoload :Cue, 'qlab-ruby/cue'
  autoload :CueList, 'qlab-ruby/cue_list'
  autoload :Machine, 'qlab-ruby/machine'
  autoload :Reply, 'qlab-ruby/reply'
  autoload :Workspace, 'qlab-ruby/workspace'

  class << self
    attr_accessor :machine, :connection

    def connect machine_address='localhost', port=53000
      # global QLab connection
      machine = Machine.new(machine_address, port)

      if machine.connected?
        machine.alwaysReply = 1
      end

      machine
    end

    def debug msg
      # puts msg
    end
  end
end
