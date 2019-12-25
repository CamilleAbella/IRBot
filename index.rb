
require 'json'
require 'discordrb'

file = File.open "./config.json"
data = JSON.load file
file.close
bot = Discordrb::Bot.new token: data['token']

puts 'Connected'

bot.message(start_with: 'irb') do |message|
  if data['authorized'].include?(message.author.id.to_s)
    message.content.sub! 'irb', ''
    message.content.strip!
    begin
      $response = eval message.content
    rescue StandardError => error
      $response = error.message
    end
    message.respond $response
  else message.respond 'You must be included in the authorized list.' end
end

bot.run
