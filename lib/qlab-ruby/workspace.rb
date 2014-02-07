module QLab
  #
  #   "uniqueID": string,
  #   "displayName": string
  #   "hasPasscode": number
  #
  class Workspace < Communicator
    attr_accessor :data, :passcode

    # Load a workspace with the attributes given in `data`
    def initialize data, machine
      @machine = machine
      self.data = data
    end

    Commands::WORKSPACE.each do |command|
      define_method(command.to_sym) do |*args|
        if args.size > 0
          send_message workspace_command(command), *args
        else
          send_message workspace_command(command)
        end
      end
    end

    def connection
      @machine.connection
    end

    def name
      data['displayName']
    end

    def passcode?
      !!data['hasPasscode']
    end

    def id
      data['uniqueID']
    end

    # all cues in this workspace in a flat list
    def cues
      cue_lists.map do |cl|
        load_cues(cl, [])
      end.flatten.compact
    end

    def has_cues?
      cues.size > 0
    end

    def cue_lists
      refresh
      @cue_lists
    end

    def refresh
      if passcode?
        if passcode.nil?
          raise WorkspaceConnectionError.new("Workspace '#{ name }' requires a passcode.")
        end

        args = [workspace_command('connect'), ('%04i' % passcode)]
      else
        args = [workspace_command('connect')]
      end
      connect_response = send_message(*args)

      if connect_response == 'ok'
        @cue_lists = []

        cues_response = send_message workspace_command('cueLists')
        cues_response.each do |cuelist|
          @cue_lists << QLab::CueList.new(cuelist, self)
        end
      end
    end

    def find_cue params={}
      cues.find do |cue|
        matches = true

        # match each key to the given cue
        params.keys.each do |key|
          matches = matches && (cue.send(key.to_sym) == params[key])
        end

        matches
      end
    end

    def new_cue type
      cue_id = send_message new_cue_command, type
      unless cue_id == 'error'
        find_cue({ :id => cue_id })
      end
    end

    private

    def workspace_command command
      "/workspace/#{id}/#{ command }"
    end

    def new_cue_command
      "/workspace/#{id}/new"
    end

    def load_cues parent_cue, cues
      parent_cue.cues.each {|child_cue|
        cues << child_cue
        load_cues child_cue, cues
      }

      cues
    end
  end

  class WorkspaceConnectionError < Exception; end
end
