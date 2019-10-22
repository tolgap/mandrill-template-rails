# frozen_string_literal: true

module MandrillRails
  class TemplateMailer < ActionMailer::Base
    layout false

    default body: '',
            content_type: 'text/html'
  end
end
