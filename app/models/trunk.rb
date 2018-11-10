# app/models/trunk.rb
class Trunk < ApplicationRecord
  belongs_to :trunk_type
  belongs_to :model
end
