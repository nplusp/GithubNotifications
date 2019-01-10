require 'spec_helper'

RSpec.describe Notifiers::Slack do
  subject { Notifiers::Slack }

  context '#message' do
    let!(:payload) { File.new('./spec/support/fixtures/push.json').read }
    let!(:data) { Webhooks::Notifier.send(:params, JSON.parse(payload))}

    let(:message) { subject.message(data) }

    it 'creates correctly' do
      expect(message).to eq('<https://github.com/Codertocat/Hello-World|Codertocat/Hello-World>
Codertocat (21031067+Codertocat@users.noreply.github.com) just commited

Total commits: 2

*****
<https://github.com/nplusp/test/commit/de2d923e66990e873381155fb2efb523a51307ed|initial commit

7 files added
0 files deleted
0 files modified

*****
<https://github.com/nplusp/test/commit/9db605d6ab12abc585b26fcb1ebf5eb304e92f2e|update commits counting

0 files added
0 files deleted
1 files modified


')
    end
  end
end
