require 'rails_helper'

RSpec.describe Mail::Message do
  describe '.mandrill_template' do
    subject do
      Mail.new { |message| message.mandrill_template 'my-mandrill-template' }
          .mandrill_template
    end

    it { is_expected.to eq('my-mandrill-template') }
  end

  describe '.mandrill_merge_vars' do
    subject do
      Mail.new { |message| message.mandrill_merge_vars vars }
          .mandrill_merge_vars
    end

    let(:vars) do
      {
        TEST: 'var',
        ANOTHER_VAR: 'test'
      }
    end

    it { is_expected.to include(TEST: 'var') }
    it { is_expected.to include(ANOTHER_VAR: 'test') }
  end

  describe '.mandrill_template_content' do
    subject do
      Mail.new { |message| message.mandrill_template_content content }
          .mandrill_template_content
    end

    let(:content) do
      {
        'content name' => 'content value'
      }
    end

    it { is_expected.to include('content name' => 'content value') }
  end
end
