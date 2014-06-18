require 'mechanize'
require 'singleton'
require './lib/storage'
require './lib/post'
require './lib/topic'
require './lib/topic_page'
require './lib/forum'
require './lib/bot'

login, password = ARGV

puts "Starting bot"
bot = Bot.new(login, password)

puts "Parsing #{Bot::BASE_URL}"
bot.parse
