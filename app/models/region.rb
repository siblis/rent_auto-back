# app/models/region.rb
class Region < ApplicationRecord
  belongs_to :state
  belongs_to :country
end
