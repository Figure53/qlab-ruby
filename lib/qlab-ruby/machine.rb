module QLab
  class Machine < Communicator
    attr_accessor :name, :address, :port

    # Connect to a running QLab instance. `address` can be a domain name or an
    # IP Address.
    def initialize(_address, _port)
      self.name = _address
      self.address = _address
      self.port = _port
      connect
    end

    # auto-generate methods first so that manually defined methods will
    # override
    Commands::MACHINE.each do |command|
      define_method(command.to_sym) do |*args|
        if args.size > 0
          send_message command, *args
        else
          send_message command
        end
      end
    end

    # Open and return a connection to the running QLab instance
    def connect
      if !connected?
        @connection = OSC::TCP::Client.new(@address, @port)
      else
        connection
      end
    end

    # Reference to the running QLab instance
    def connection
      @connection || connect
    end

    # The workspaces provided by the connected QLab instance
    def workspaces
      @workspaces || load_workspaces
    end


    # Find a workspace according to the given params.
    def find_workspace params={}
      workspaces.find do |ws|
        matches = true

        # match each key to the given workspace
        params.keys.each do |key|
          matches = matches && (ws.send(key.to_sym) == params[key])
        end

        matches
      end
    end

    def connected?
      !(@connection.nil? || send_message('/version').nil?)
    end

    def close
      @connection.close
      @connection = nil
    end

    def refresh
      close
      connect
      load_workspaces
    end

    def alwaysReply=(value)
      # send set command
      alwaysReply(value)
    end

    private

    def load_workspaces
      @workspaces = []

      data = send_message('/workspaces')

      data.map do |ws|
        @workspaces << QLab::Workspace.new(ws, self)
      end

      @workspaces
    end
  end
end
