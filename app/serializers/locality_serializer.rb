class LocalitySerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :status
  has_one :region
  has_one :state
  has_one :country
end
