# app/models/rental_price.rb
class RentalPrice < ApplicationRecord
  belongs_to :model
  belongs_to :model_class

  attribute :day_price, :money
  attribute :forfeit_price, :money
  attribute :earnest, :money
  attribute :km_price, :money
  attribute :km_over_price, :money
  attribute :weekend_price, :money
  attribute :workweek_price, :money
  attribute :workday_price, :money
end
