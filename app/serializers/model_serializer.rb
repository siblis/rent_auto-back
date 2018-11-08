class ModelSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :note
  has_one :brand
  has_one :manufacture
  has_one :body_type
  attribute :full_name do
    "#{object.brand.name} #{object.name}"
  end
end
