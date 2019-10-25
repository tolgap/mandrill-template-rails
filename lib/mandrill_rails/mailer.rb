module MandrillRails
  class Mailer
    attr_accessor :client

    def initialize(_config = {})
      @client = Mandrill::API.new(
        MandrillRails.api_key,
        MandrillRails.debug
      )
    end

    def deliver!(mail)
      template_name = mail.mandrill_template
      recipients = MandrillRails.transform_recipients(mail)
      merge_vars = mail.mandrill_merge_vars.map do |k, v|
        { name: k.to_s, content: v&.to_s }
      end
      template_content = mail.mandrill_template_content.map do |k, v|
        { name: k.to_s, content: v&.to_s }
      end

      response = client.messages.send_template(
        template_name,
        template_content,
        {
          to: recipients,
          global_merge_vars: merge_vars
        }
      )

      mail.message_id = response.first[:_id]

      response
    end
  end
end
