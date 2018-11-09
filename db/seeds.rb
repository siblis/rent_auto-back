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
BODY_TYPES = %w(автобус внедорожник кабриолет кроссовер купе лимузин лифтбэк микроавтобус минивэн пикап родстер
                седан стретч тарга универсал фургон хэтчбек)

# puts Faker::Russian.passport

# Удаляем все записи
Model.destroy_all
Manufacture.destroy_all
Brand.destroy_all
BodyType.destroy_all

Locality.destroy_all
Region.destroy_all
State.destroy_all
Country.destroy_all
Status.destroy_all

puts 'Генерируем базу:'
# Заполняем справочник статусов населенных пунктов
print ' - справочник статусов населенных пунктов'
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

# Заполняем справочник типов кузовов автомобилей
print ' - справочник типов кузовов автомобилей'
seeds = BODY_TYPES.map do |type|
  print '.'
  {
    code: type.downcase.gsub(/(\W)[аеёийоуъыьэюя]/,'\1')[0..2],
    name: type,
    note: type.capitalize
  }
end
body_types = BodyType.create! seeds
puts

# генерируем данные для окружения разработки
if Rails.env.development?

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

  # Заполняем справочник бредов
  print ' - справочник брендов'
  seeds = MAX_SEEDS.times.map do
    print '.'
    company = Faker::Company
    make = Faker::Vehicle.make
    {
      code: make[0..2].downcase + rand(0..9).to_s,
      name: make,
      note: company.catch_phrase
    }
  end
  brands = Brand.create! seeds
  puts

  # Заполняем справочник производителей
  print ' - справочник производителей'
  seeds = MAX_SEEDS.times.map do
    print '.'
    company = Faker::Company
    manufacture = Faker::Vehicle.manufacture
    {
      code: manufacture[0..2].downcase + rand(0..9).to_s,
      name: manufacture,
      brand: brands.sample,
      country: countries.sample,
      note: company.catch_phrase
    }
  end
  manufactures = Manufacture.create! seeds
  puts

  # Заполняем справочник моделей автомобилей
  print ' - справочник моделей автомобилей'
  seeds = MAX_SEEDS.times.map do
    print '.'
    company = Faker::Company
    model = Faker::Vehicle.model
    {
      code: model[0..2].downcase + rand(0..9).to_s,
      name: model,
      brand: brands.sample,
      manufacture: manufactures.sample,
      body_type: body_types.sample,
      door_count: rand(2..7),
      seat_count: rand(2..7),
      style: Faker::Vehicle.style,
      transmission: Faker::Vehicle.transmission,
      drive_type: Faker::Vehicle.drive_type,
      fuel_type: Faker::Vehicle.fuel_type,
      engine: Faker::Vehicle.engine,
      engine_volume: rand(10..50).to_f/10,
      options: Faker::Vehicle.car_options,
      note: company.catch_phrase
    }
  end
  models = Model.create! seeds
  puts

end
