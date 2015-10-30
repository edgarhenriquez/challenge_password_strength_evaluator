require 'rubygems'
require 'chatterbot/dsl'

class RankMyPasswordBot < Chatterbot::Bot

  def initialize
  end

  def run
    loop do
      bot.replies do |tweet|
        text = tweet.text
        puts "message received: #{text}"
      end

      bot.update_config # To keep track of the last tweet processed
      sleep 90 # Twitter API rate limit (15 requests every 15 minutes)
    end
  end

end

bot = RankMyPasswordBot.new
bot.run
