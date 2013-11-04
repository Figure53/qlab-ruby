module QLab
  class Machine < Communicator
    attr_accessor :name, :address, :port

    def initialize(_address, _port)
      @name = _address
      @address = _address
      @port = _port

      refresh
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

    def connection
      @connection ||= OSC::TCP::Client.new(@address, @port)
    end

    def workspaces
      @workspaces ||= load_workspaces
    end

    def workspace_names
      workspaces.map(&:name) || []
    end

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
      !@connection.nil?
    end

    def close
      @connection.close
      @connection = nil
    end

    def refresh
      @workspaces = load_workspaces
    end

    def alwaysReply=(value)
      # send set command
      alwaysReply(value)
    end

    private

    def load_workspaces
      data = send_message('/workspaces')

      data.map do |ws|
        QLab::Workspace.new(ws, self)
      end
    end
  end
end
