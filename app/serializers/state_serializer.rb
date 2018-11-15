# app/serializers/state_serializer.rb
class StateSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :country
end
