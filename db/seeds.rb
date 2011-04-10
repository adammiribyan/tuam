# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

clients = Client.create([
  { :full_name => 'Иванов Сергей Петрович' }, 
  { :full_name => 'Тющенко Владимир Николаевич' },
  { :full_name => 'Сорокина Ирина Геннадьевна'}])