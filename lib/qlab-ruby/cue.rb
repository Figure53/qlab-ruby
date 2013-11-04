module QLab
  class Cue < Communicator
    attr_accessor :data, :workspace

    def initialize data, cue_list
      self.data = data
      @cue_list = cue_list
    end

    # send command
    Commands::ALL_CUES.each do |command|
      define_method(command.to_sym) do |*args|
        if args.size > 0
          send_message cue_command(command), *args
        else
          send_message cue_command(command)
        end
      end
    end

    # Define commands with single settable values as command= methods
    # for convenience. All command-as-method commands will act as setters
    # if given an argument.
    #
    # For exmaple:
    #
    #   cue.name = "A Name"
    #
    # is functionally equivalent to
    #
    #   cue.name("A Name")
    #
    # as far as QLab is concerned
    #
    Commands::SET_CUES.each do |command|
      define_method("#{ command }=".to_sym) do |value|
        send_message cue_command(command), value
      end
    end

    def workspace
      @cue_list.workspace
    end

    def connection
      workspace.connection
    end

    def id
      data['uniqueID']
    end

    def cues
      if data['cues'].nil?
        []
      else
        data['cues'].map {|c| Cue.new(c, @cue_list)}
      end
    end

    def has_cues?
      cues.size > 0
    end

    # another Cue
    def ==(other)
      if other.is_a?(Cue)
        self.data = other.data
      else
        false
      end
    end

    private

    def cue_command command
      "/workspace/#{ workspace.id }/cue_id/#{ id }/#{ command }"
    end
  end
end
