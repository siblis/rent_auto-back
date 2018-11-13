# app/serializers/rental_rate_serializer.rb
class RentalRateSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :workweek_rate, :weekend_rate, :hour_rate, :note
  has_one :model
  has_one :rental_type
end
