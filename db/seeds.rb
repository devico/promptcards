# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'

user = User.create!(email: 'qaz@zaq.ru', password: '123321', password_confirmation: '123321')

block = user.blocks.create(title: 'Home things')

doc = Nokogiri::HTML(open('https://www.learnathome.ru/blog/100-beautiful-words'))

doc.search('//table/tbody/tr').each do |row|
  original = row.search('td[2]')[0].content.downcase
  translated = row.search('td[4]')[0].content.downcase
  block.cards.create(original_text: original, translated_text: translated, user_id: user.id)
end

default_user = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
default_user.role = 1
default_user.save
