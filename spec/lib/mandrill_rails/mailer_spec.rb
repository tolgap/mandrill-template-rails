require 'rails_helper'

RSpec.describe MandrillRails::Mailer do
  before do
    MandrillRails.configure do |config|
      config.api_key = 'test'
      config.debug = true
    end
  end

  after do
    MandrillRails.configure do |config|
      config.api_key = nil
      config.debug = nil
    end
  end

  subject(:mailer) { described_class.new }

  describe '.client' do
    subject { mailer.client }

    it { is_expected.to be_instance_of(Mandrill::API) }
  end

  describe '.deliver!' do
    let!(:merge_vars) { { test_name: 'test_value' } }
    let(:mail) do
      Mail.new do |message|
        message.to 'test1@example.com'
        message.mandrill_template 'test_template'
        message.mandrill_merge_vars merge_vars
      end
    end
    let(:response) do
      [
        {
          email: 'test1@example.com',
          status: 'sent',
          _id: '20191015_586f9a75a557405b8a33e56add9cf093'
        }
      ]
    end

    it 'sends an API call to mandrill' do
      expect_any_instance_of(Mandrill::Messages).to receive(:send_template)
        .with(
          'test_template',
          [],
          to: [{ email: 'test1@example.com', type: 'to' }],
          global_merge_vars: [{ name: 'test_name', content: 'test_value' }]
        ).and_return(response)

      expect { mailer.deliver!(mail) }
        .to change { mail.message_id }
        .to('20191015_586f9a75a557405b8a33e56add9cf093')
    end
  end
end
