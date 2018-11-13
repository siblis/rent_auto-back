# app/serializers/rental_price_serializer.rb
class RentalPriceSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :day_price, :forfeit_price, :earnest, :km_price, :km_over_price, :weekend_price, :workweek_price, :workday_price, :note
  has_one :model
  has_one :model_class
end
