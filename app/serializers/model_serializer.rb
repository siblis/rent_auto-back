# app/serializers/model_serializer.rb
class ModelSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :active, :door_count, :seat_count, :style, :transmission,
             :drive_type, :fuel_type, :engine, :engine_volume, :options, :note
  has_one :brand
  has_one :manufacture
  has_one :body_type
  attribute :full_name do
    "#{object.brand.name} #{object.name} #{object.engine_volume} #{object.style}"
  end
end
