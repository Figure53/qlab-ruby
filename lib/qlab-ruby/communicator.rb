module QLab
  # An abstract class providing communication behavior for objects that need to
  # interact with QLab.
  class Communicator

    def send_message osc_address, *osc_arguments
      osc_address = format_osc_address(osc_address)

      if osc_arguments.size > 0
        osc_message = OSC::Message.new osc_address, *osc_arguments
      else
        osc_message = OSC::Message.new osc_address
      end
      responses = []

      QLab.debug "[Action send_message] send #{ osc_message.encode }"
      connection.send(osc_message) do |response|
        responses << QLab::Reply.new(response)
      end

      if responses.size == 1
        q_reply = responses[0]
        QLab.debug "[Action send_message] got one response: #{q_reply.inspect}"

        if q_reply.has_data?
          QLab.debug "[Action send_message] single response has data: #{q_reply.data.inspect}"
          q_reply.data
        elsif q_reply.has_status?
          QLab.debug "[Action send_message] single response has status: #{q_reply.status.inspect}"
          q_reply.status
        else
          QLab.debug "[Action send_message] single response has no data or status: #{q_reply.inspect}"
          q_reply
        end
      else
        responses
      end
    end

    private

    def format_osc_address address
      if %r[^/] !~ address.to_s
        "/#{ address }"
      else
        address
      end
    end

  end
end
