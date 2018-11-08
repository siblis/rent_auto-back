# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
# Faker::Config.locale = 'ru'

MAX_SEEDS = 10
LOCALITY_STATUSES =  [['аул', 'аул'],
                      ['г.', 'город'],
                      ['дер.', 'деревня'],
                      ['ж/д ст.''железнодорожная станция'],
                      ['н.п.', 'населенный пунк'],
                      ['п.', 'поселок'],
                      ['п.г.т.', 'поселок городского типа'],
                      ['с.', 'село'],
                      ['сл.', 'слобода'],
                      ['ст.', 'станица']]

# Удаляем все записи
Locality.destroy_all
Region.destroy_all
State.destroy_all
Country.destroy_all
Status.destroy_all

Brand.destroy_all

# puts Faker::Russian.passport
puts 'Генерируем базу:'
# Заполняем справочник статусов населенных пунктов
print ' - справочник статусов'
seeds = LOCALITY_STATUSES.map do |a|
  print '.'
  {
    code: a[0],
    name: a[1],
    note: nil
  }
end
statuses = Status.create! seeds
puts

# Заполняем справочник стран
print ' - справочник стран'
seeds = MAX_SEEDS.times.map do
  print '.'
  address = Faker::Address
  {
    code: address.country_code,
    name: address.country,
    note: address.community
  }
end
countries = Country.create! seeds
puts

# Заполняем справочник округов
print ' - справочник округов'
seeds = MAX_SEEDS.times.map do
  print '.'
  address = Faker::Address
  {
    code: address.state_abbr,
    name: address.state,
    country: countries.sample,
    note: address.community
  }
end
states = State.create! seeds
puts

# Заполняем справочник областей
print ' - справочник областей'
seeds = MAX_SEEDS.times.map do
  print '.'
  address = Faker::Address
  {
    code: address.state_abbr,
    name: address.state,
    state: states.sample,
    country: countries.sample,
    note: address.community
  }
end
regions = Region.create! seeds
puts

# Заполняем справочник населенных пунктов
print ' - справочник населенных пунктов'
seeds = MAX_SEEDS.times.map do
  print '.'
  address = Faker::Address
  {
    code: address.state_abbr,
    name: address.city,
    status: statuses.sample,
    region: regions.sample,
    state: states.sample,
    country: countries.sample,
    note: address.community
  }
end
localities = Locality.create! seeds
puts

# Заполняем справочник бредов: brands
print ' - справочник брендов'
seeds = MAX_SEEDS.times.map do
  print '.'
  company = Faker::Company
  {
    code: company.duns_number,
    name: company.name,
    note: company.catch_phrase
  }
end
brands = Brand.create! seeds
puts
