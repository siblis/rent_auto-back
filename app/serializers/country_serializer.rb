class CountrySerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
end
