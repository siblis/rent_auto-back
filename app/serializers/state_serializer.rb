class StateSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :country
  # has_one :country do
  #   {
  #     code: object.country.code,
  #     name: object.country.name
  #   }
  # end
end
