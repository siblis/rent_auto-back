class BrandSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
end
