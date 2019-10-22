# frozen_string_literal: true

require 'mail'
require 'mandrill'
require 'mandrill_rails/railtie'
require 'mandrill_rails/message'
require 'mandrill_rails/mailer'

module MandrillRails
  class << self
    attr_accessor :api_key, :debug

    def configure
      yield self
      true
    end
    alias config configure

    def transform_recipients(mail)
      %i[to cc bcc].map do |rcpt_type|
        addrs = mail[rcpt_type] || nil
        transform_recipient(addrs, rcpt_type)
      end.flatten.compact
    end

    def transform_recipient(addrs, rcpt_type)
      case addrs
      when String
        # Likely a single recipient
        { email: addrs, type: rcpt_type.to_s }
      when Array
        addrs.map do |addr|
          { email: addr, type: rcpt_type.to_s }
        end
      when Mail::Field
        { email: addrs.to_s, type: rcpt_type.to_s }
      end
    end
  end
end
