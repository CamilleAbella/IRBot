
require "json"
require 'discordrb'

file = File.open "./config.json"
data = JSON.load file
bot = Discordrb::Bot.new token: data['token']

bot.message(start_with: /^eval\s+\S+/) do |message|
  if data['authorized'].include? message.author.id
    message.content.strip!
    message.content.sub! /^eval\s+/, ''
    response = ''
    begin
      response += eval(message.content)
    rescue
      response = 'Error...'
    end
    message.respond response
  else
    message.respond 'You must be included in the authorized list.'
  end
end

bot.run
