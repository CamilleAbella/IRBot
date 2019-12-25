
require "json"
require 'discordrb'

file = File.open "./config.json"
data = JSON.load file
bot = Discordrb::Bot.new token: data['token']

bot.message(start_with: /^eval\s+\S+/) do |message|
  if data['authorized'].include? message.author.id
    message.content.sub! /^eval\s+/, ''
    message.content.strip!
    response = ''
    begin
      response += eval(message.content)
    rescue StandardError => error
      response = error.message
    end
    message.respond response
  else
    message.respond 'You must be included in the authorized list.'
  end
end

bot.run
