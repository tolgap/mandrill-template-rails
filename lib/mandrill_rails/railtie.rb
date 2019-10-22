# frozen_string_literal: true

module MandrillRails
  class Railtie < ::Rails::Railtie
    config.before_configuration do
      ActionMailer::Base.add_delivery_method :mandrill, MandrillRails::Mailer
    end
  end
end
