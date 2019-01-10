require 'slack-notifier'

module Notifiers
  class Slack
    WEBHOOK_URL = 'https://hooks.slack.com/services/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'.freeze

    class << self
      def send_message(data)
        notifier = ::Slack::Notifier.new(WEBHOOK_URL, username: 'Github Bot', icon_emoji: ":star:")
        notifier.ping(message(data))
      end

      def message(data)
        <<~HEREDOC
          <#{data[:repo_url]}|#{data[:repo_name]}>
          #{data[:name]} (#{data[:email]}) just commited

          Total commits: #{data[:commits].size}

          #{data[:commits].map{|commit|
            <<~INNER
              *****
              <#{commit.fetch('url', data[:repo_url])}|#{commit.fetch('message', 'blank')}>

              #{commit.fetch('added', []).size} files added
              #{commit.fetch('deleted', []).size} files deleted
              #{commit.fetch('modified', []).size} files modified

            INNER
          }.join('')}
        HEREDOC
      end
    end
  end
end
