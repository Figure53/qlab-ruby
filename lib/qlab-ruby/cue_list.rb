module QLab
  #  An array of cue objects:
  #
  #  [
  #      {
  #          "uniqueID": string,
  #          "number": string
  #          "name": string
  #          "type": string
  #          "colorName": string
  #          "flagged": number
  #          "armed": number
  #      }
  #  ]
  #
  #  If a given cue is a group, it will include the nested cues:
  #
  #  [
  #      {
  #          "uniqueID": string,
  #          "number": string
  #          "name": string
  #          "type": string
  #          "colorName": string
  #          "flagged": number
  #          "armed": number
  #          "cues": [ { }, { }, { } ]
  #      }
  #  ]

  class CueList
    attr_accessor :data

    # Load a cue list with the attributes given in `data`
    def initialize data, workspace
      self.data = data
      @workspace = workspace
    end

    def workspace
      @workspace
    end

    def id
      data['uniqueID']
    end

    def name
      data['listName']
    end

    def number
      data['number']
    end

    def type
      data['type']
    end

    def cues
      if data['cues'].nil?
        []
      else
        data['cues'].map {|c| QLab::Cue.new(c, self)}
      end
    end

    def has_cues?
      cues.size > 0
    end
  end
end
