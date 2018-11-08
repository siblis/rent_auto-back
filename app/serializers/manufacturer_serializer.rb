class ManufacturerSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :brand
  has_one :country
end
