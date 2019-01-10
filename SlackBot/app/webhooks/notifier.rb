require 'json'
require_relative '../notifiers/slack'

module Webhooks
  class Notifier
    class << self
      def handler(event:, context:)
        body = JSON.parse(event['body'])

        Notifiers::Slack.send_message(params(body))
        { statusCode: 200, body: JSON.generate({ message: 'ok' }) }
      rescue => e
        { statusCode: 500, body: JSON.generate({ message: e.to_s, event: event, context: context }) }
      end

      private

      def params(body)
        {
          name: body.dig('pusher', 'name') || 'No Name',
          email: body.dig('pusher', 'email') || 'No Email',
          repo_name: body.dig('repository', 'full_name'),
          repo_url: body.dig('repository', 'html_url'),
          commits: body.fetch('commits', [])
        }
      end
    end
  end
end
