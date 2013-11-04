module QLab
  #  All return an array of cue dictionaries:
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
  #  If the cue is a group, the dictionary will include an array of cue dictionaries for all children in the group:
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
  #
  #  [{\"number\":\"\",
  #    \"uniqueID\":\"1\",
  #    \"cues\":[{\"number\":\"1\",
  #    \"uniqueID\":\"2\",
  #    \"flagged\":false,
  #    \"type\":\"Wait\",
  #    \"colorName\":\"none\",
  #    \"name\":\"boom\",
  #    \"armed\":true}],
  #    \"flagged\":false,
  #    \"type\":\"Group\",
  #    \"colorName\":\"none\",
  #    \"name\":\"Main Cue List\",
  #    \"armed\":true}]

  class CueList
    attr_accessor :data

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
