# app/serializers/region_serializer.rb
class RegionSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :state
  has_one :country
end
