# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Faker::Config.locale = 'ru'
Money.locale_backend = :i18n

MAX_SEEDS = 10
# выглядит по дурацки, но рубокоп цук злой
LOCALITY_STATUSES = [%w[аул аул],
                     %w[г. город],
                     %w[дер. деревня],
                     %w[ж/д\ ст. железнодорожная\ станция],
                     %w[н.п. населенный\ пункт],
                     %w[п. поселок],
                     %w[п.г.т. поселок\ городского\ типа],
                     %w[с. село],
                     %w[сл. слобода],
                     %w[ст. станица]].freeze
MODEL_CLASSES = %w[бизнес премиум эконом].freeze

BODY_TYPES = %w[автобус внедорожник кабриолет кроссовер купе лимузин лифтбэк микроавтобус минивэн пикап
                родстер седан стретч тарга универсал фургон хэтчбек].freeze

RENTAL_TYPES = %w[основной демисезон зимний летний].freeze

DAY_RANGES = [[1,3],[3,7],[7,15],[15,30],[30,nil]].freeze

# Удаляем базовые записи
# DayRange.destroy_all
# BodyType.destroy_all
# ModelClass.destroy_all
# Status.destroy_all

puts 'Генерируем базу:'

# Заполняем справочник статусов населенных пунктов
print ' • справочник статусов населенных пунктов'
seeds = LOCALITY_STATUSES.inject([]) do |arr,stat|
  print '.'
  arr << {
    code: stat[0],
    name: stat[1],
    note: stat[1].capitalize
  } if Status.find_by_code(stat[0]).blank?
end
statuses = seeds.blank? ? Status.all : Status.create!(seeds)
puts

# Заполняем справочник классов моделей автомобилей
print ' • справочник классов моделей автомобилей'
seeds = MODEL_CLASSES.inject([]) do |arr,klass|
  print '.'
  code = klass.downcase.gsub(/(\W)[аеёийоуъыьэюя]/, '\1')[0..2]
  arr << {
    code: code,
    name: klass,
    note: klass.capitalize
  } if ModelClass.find_by_code(code).blank?
end
model_classes = seeds.blank? ? ModelClass.all : ModelClass.create!(seeds)
puts

# Заполняем справочник типов кузовов автомобилей
print ' • справочник типов кузовов автомобилей'
seeds = BODY_TYPES.inject([]) do |arr,type|
  print '.'
  code = type.downcase.gsub(/(\W)[аеёийоуъыьэюя]/, '\1')[0..2]
  arr << {
    code: code,
    name: type,
    note: type.capitalize
  } if BodyType.find_by_code(code).blank?
end
body_types = seeds.blank? ? BodyType.all : BodyType.create!(seeds)
puts

# Заполняем справочник типов тарифных планов
print ' • справочник типов тарифных планов'
seeds = RENTAL_TYPES.inject([]) do |arr,type|
  print '.'
  code = type.downcase.gsub(/(\W)[аеёийоуъыьэюя]/, '\1')[0..2]
  arr << {
    code: code,
    name: type,
    note: type.capitalize
  } if RentalType.find_by_code(code).blank?
end
rental_types = seeds.blank? ? RentalType.all : RentalType.create!(seeds)
puts

# Заполняем справочник диапазонов дней аренды
print ' • справочник диапазонов дней аренды'
seeds = DAY_RANGES.inject([]) do |arr,range|
  print '.'
  code = "days#{range[0]}" + (range[1].nil? ? '+' : "-#{range[1]}")
  range_name = "от #{range[0]}" 
  range_name += " до #{range[1]}" unless range[1].nil?
  range_name += ' дней'
  arr << {
    code: code,
    name: range_name,
    day_from: range[0],
    day_to: range[1],
    note: range_name.capitalize
  } if DayRange.find_by_code(code).blank?
end
day_ranges = seeds.blank? ? DayRange.all : DayRange.create!(seeds)
puts

# Заполняем данные для окружения разработки
if Rails.env.development?
  # Удаляем сгенерированные записи
  RentalPrice.destroy_all
  RangeRate.destroy_all
  RentalRate.destroy_all

  Model.destroy_all
  Manufacture.destroy_all
  Brand.destroy_all

  Locality.destroy_all
  Region.destroy_all
  State.destroy_all
  Country.destroy_all

  # Заполняем справочник стран
  print ' • справочник стран'
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
  print ' • справочник округов'
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
  print ' • справочник областей'
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
  print ' • справочник населенных пунктов'
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
  print ' • справочник брендов'
  seeds = MAX_SEEDS.times.map do
    print '.'
    make = Faker::Vehicle.make
    {
      code: make[0..2].downcase + rand(0..9).to_s,
      name: make,
      note: Faker::Company.catch_phrase
    }
  end
  brands = Brand.create! seeds
  puts

  # Заполняем справочник производителей
  print ' • справочник производителей'
  seeds = MAX_SEEDS.times.map do
    print '.'
    manufacture = Faker::Vehicle.manufacture
    {
      code: manufacture[0..2].downcase + rand(0..9).to_s,
      name: manufacture,
      brand: brands.sample,
      country: countries.sample,
      note: Faker::Company.catch_phrase
    }
  end
  manufactures = Manufacture.create! seeds
  puts

  # Заполняем справочник моделей автомобилей
  print ' • справочник моделей автомобилей'
  seeds = MAX_SEEDS.times.map do
    print '.'
    model = Faker::Vehicle.model
    {
      code: model[0..2].downcase + rand(0..9).to_s,
      name: model,
      brand: brands.sample,
      model_class: model_classes.sample,
      manufacture: manufactures.sample,
      body_type: body_types.sample,
      door_count: rand(2..7),
      seat_count: rand(2..7),
      style: Faker::Vehicle.style,
      transmission: Faker::Vehicle.transmission,
      drive_type: Faker::Vehicle.drive_type,
      fuel_type: Faker::Vehicle.fuel_type,
      engine: Faker::Vehicle.engine,
      engine_volume: rand(10..50).to_f / 10,
      options: Faker::Vehicle.car_options,
      note: Faker::Company.catch_phrase
    }
  end
  models = Model.create! seeds
  puts

  # Заполняем справочник коэффициентов тарифных планов
  print ' • справочник коэффициентов тарифных планов'
  seeds = models.map do |model|
    rental_types.map do |type|
      print '.'
      rate_name = "#{model.name}(#{type.name})"
      {
        code: "#{model.code}-#{type.code}",
        name: rate_name,
        model: model,
        rental_type: type,
        workweek_rate: rand(5..15).to_f / 10,
        weekend_rate: rand(5..15).to_f / 10,
        hour_rate: rand(5..15).to_f / 10,
        note: rate_name
      }
    end
  end
  rental_rates = RentalRate.create! seeds.flatten
  puts

  # Заполняем связки коэффициентов и диапазонов дней
  print ' • связки коэффициентов и диапазонов дней'
  seeds = rental_rates.map do |rate|
    day_ranges.map do |range|
      print '.'
      rate_name = "#{rate.name}(#{range.name})"
      {
        code: "#{rate.code}-#{range.code}",
        name: rate_name,
        rental_rate: rate,
        day_range: range,
        rate: rand(80..100).to_f / 100,
        note: rate_name
      }
    end
  end
  range_rates = RangeRate.create! seeds.flatten
  puts

  # Заполняем справочник базовых цен для моделей (классов?)
  print ' • справочник базовых цен для моделей (классов?)'
  seeds = models.map do |model|
    price_name = "#{model.name}(#{model.model_class.name})"
    # Money принимает значение в копейках (ну не дурость?)
    # day_price = Money.new(rand(20..30) * 100 * 100)
    # km_price = Money.new(rand(50..100) / 10 * 100)
    day_price = rand(20..30) * 100
    km_price = rand(50..100) / 10
    print '.'
    {
      code: "#{model.code}-#{model.model_class.code}",
      name: price_name,
      model: model,
      model_class: model.model_class,
      # day_price: day_price.to_f,
      # forfeit_price: (day_price * 1.5).to_f,
      # earnest: (day_price * 3).to_f,
      # km_price: km_price.to_f,
      # km_over_price: (km_price * 1.5).to_f,
      # weekend_price: (day_price * 2 * 1.5).to_f,
      # workweek_price: (day_price * 4).to_f,
      # workday_price: (day_price * 0.9).to_f,
      day_price: day_price,
      forfeit_price: day_price * 1.5,
      earnest: day_price * 3,
      km_price: km_price,
      km_over_price: km_price * 1.5,
      weekend_price: day_price * 2 * 1.5,
      workweek_price: day_price * 4,
      workday_price: day_price * 0.9,
      note: price_name
    }
  end
  rental_prices = RentalPrice.create! seeds
  puts

end
