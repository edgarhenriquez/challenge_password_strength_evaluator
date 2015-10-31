# RankMyPasswordBot

RankMyPasswordBot is a simple Twitter bot that apply a custom algorithm to evaluate the strength of any password received.

## Usage

1. Clone the repository

        $ git clone `git@github.com:edgarhenriquez/challenge_password_strength_evaluator.git`
        $ cd challenge_password_strength_evaluator

2. Install the dependencies

        $ bundle

3. Create a configuration file to set up your bot's Twitter credentials.

        $ touch rankmypasswordbot.yml

3. Run the bot from the command line

    bundle exec ruby rankmypasswordbot.rb

4. That is it.

## Configuration file

An example configuration file looks like

    ---
    :consumer_key: <YOUR CONSUMER KEY>
    :consumer_secret: <YOUR CONSUMER SECRET>
    :token: <YOUR TOKEN>
    :secret: <YOUR SECRET>

You can read about how to get these credentials [here](http://muffinista.github.io/chatterbot/configuration.html).
