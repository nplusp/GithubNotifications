require 'rspec'
require 'webmock/rspec'
require 'awesome_print'

require_relative '../app/webhooks/notifier'
require_relative '../app/notifiers/slack'

RSpec.configure do |config|
  config.order = :random

  WebMock.disable_net_connect!
end
