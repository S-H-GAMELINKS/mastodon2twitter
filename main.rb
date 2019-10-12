require 'dotenv'
require 'mastodon'
require 'twitter'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_COMSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_COMSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
end

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_ACCESS_TOKEN"])

while true
    begin
        stream.user(){|toot|
            puts toot.content
            client.update(toot.content)
        }
    rescue => error
        puts error
    end
end