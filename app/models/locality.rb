# app/models/locality.rb
class Locality < ApplicationRecord
  belongs_to :status
  belongs_to :region
  belongs_to :state
  belongs_to :country
end
