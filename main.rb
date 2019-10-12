require 'dotenv'
require 'mastodon'

Dotenv.load

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_ACCESS_TOKEN"])

while true
    begin
        stream.user(){|toot|
            puts toot.content
        }
    rescue => error
        puts error
    end
end