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
    def connect machine_address='localhost', port=53000
      begin
        # global QLab connection
        new_machine = Machine.new(machine_address, port)
      rescue Errno::ECONNREFUSED
        puts "Failed to connect to QLab machine at #{machine_address}:#{port}, please make sure your values are correct and QLab is running."
        raise
      end

      if new_machine.connected?
        new_machine.alwaysReply = 1
      end

      new_machine
    end

    def debug msg
      # puts msg
    end
  end
end
