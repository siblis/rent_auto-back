# app/models/trunk.rb
class Trunk < ApplicationRecord
  belongs_to :model
  belongs_to :trunk_type

  attribute :price, :money
end
