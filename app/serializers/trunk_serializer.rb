# app/serializers/trunk_serializer.rb
class TrunkSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :trunk_type
  has_one :model
end
