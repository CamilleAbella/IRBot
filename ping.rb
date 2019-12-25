
require "json"
require 'discordrb'

file = File.open "./config.json"
data = JSON.load file
bot = Discordrb::Bot.new token: data['token']

bot.message(content: 'ping') do |event|
  event.respond 'Pong!'
end

bot.run
