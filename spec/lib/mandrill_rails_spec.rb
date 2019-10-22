require 'rails_helper'

RSpec.describe MandrillRails do
  context 'on load' do
    describe '.configure' do
      it 'yields control to specify config params' do
        expect { |b| described_class.configure(&b) }.to yield_with_args(described_class)
      end
    end
  end

  context 'after load' do
    before do
      described_class.configure do |config|
        config.api_key = 'test'
        config.debug = false
      end
    end

    after do
      described_class.configure do |config|
        config.api_key = nil
        config.debug = nil
      end
    end

    describe '.api_key' do
      subject { described_class.api_key }

      it { is_expected.to eq('test') }
    end

    describe '.debug' do
      subject { described_class.debug }

      it { is_expected.to be false }
    end
  end

  describe '.transform_recipients' do
    let(:mail) do
      Mail.new do
        to 'test1@example.com'
        cc %w[test2@example.com test3@example.com]
        bcc Mail::Field.parse('Bcc: Test4 <test4@example.com>')
      end
    end

    subject { MandrillRails.transform_recipients(mail) }

    it { is_expected.to include(email: 'test1@example.com', type: 'to') }
    it { is_expected.to include(email: 'test2@example.com, test3@example.com', type: 'cc') }
    it { is_expected.to include(email: 'Test4 <test4@example.com>', type: 'bcc') }
  end
end
