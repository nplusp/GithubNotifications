require 'spec_helper'

RSpec.describe Webhooks::Notifier do
  subject { Webhooks::Notifier }

  context '#handler' do
    let!(:payload) { File.new('./spec/support/fixtures/push.json').read }
    let!(:context) { {} }
    let!(:event) {
      {
        'headers' => {
          'X-GitHub-Delivery' => 'e29fcd40-147a-11e9-951a-578fe365eb2c',
          'X-GitHub-Event' => 'push'
        },
        'body' => payload
      }
    }

    let(:response) { subject.handler(event: event, context: context) }

    it 'responds successfully' do
      allow(Notifiers::Slack).to receive(:send_message).and_return(true)

      expect(response).to include(statusCode: 200)
    end
  end
end
