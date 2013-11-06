require 'json'

module QLab
  # QLab OSC reply unpacker.
  class Reply < Struct.new(:osc_message)
    def address
      @address ||= json['address']
    end

    def data
      @data ||= json['data']
    end

    def status
      @status ||= json['status']
    end

    def has_data?
      !data.nil?
    end

    def has_status?
      !status.nil?
    end

    def ok?
      status == 'ok'
    end

    def empty?
      false
    end

    def to_s
      "<QLab::Reply address:'#{address}' status:'#{status}' data:#{data.inspect}>"
    end

    protected

    # Actually perform the message unpacking
    def json
      @json ||= begin
                  JSON.parse(osc_message.to_a.first)
                rescue => ex
                  puts ex.message
                  {}
                end
    end

  end
end
