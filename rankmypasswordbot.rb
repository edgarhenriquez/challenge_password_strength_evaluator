require 'rubygems'
require 'chatterbot/dsl'
require_relative 'lib/password_strength_evaluator'

class RankMyPasswordBot < Chatterbot::Bot

  def initialize
    @evaluator = PasswordStrengthEvaluator.new
    @responses = {
      strong: 'Hey, congratulations! Your password is strong :)',
      weak: 'Your password is weak :|',
      unacceptable: 'You should try again! Your password is too weak :('
    }
  end

  def run
    loop do
      bot.replies do |tweet|
        text = tweet.text
        puts "BOT:: message received: #{text}"

        password = text.gsub(/@rankmypassword/, '')
        friendly_strength = @evaluator.friendly_strength(password)

        if /Weak/.match(friendly_strength)
          new_password = @evaluator.strengthen(password)
        end

        response = case friendly_strength
                   when /Strong/ then @responses[:strong]
                   when /Weak/ then new_password
                   else @responses[:unacceptable]
                   end

        friendly_response = "#USER# #{response}"
        puts "BOT:: message sent: #{friendly_response}"
        reply friendly_response, tweet
      end

      bot.update_config # To keep track of the last tweet processed
      sleep 90 # Twitter API rate limit (15 requests every 15 minutes)
    end
  end

end

bot = RankMyPasswordBot.new
bot.run
