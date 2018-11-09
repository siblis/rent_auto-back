class Manufacture < ApplicationRecord
  belongs_to :brand
  belongs_to :country
end
