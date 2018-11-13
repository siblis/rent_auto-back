# db/migrate/20181112165440_create_rental_prices.rb
class CreateRentalPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_prices, comment: 'Справчник базовых цен для моделей (классов?)' do |t|
      t.string :code
      t.string :name
      t.references :model, foreign_key: true
      t.references :model_class, foreign_key: true
      t.decimal :day_price
      t.decimal :forfeit_price
      t.decimal :earnest
      t.decimal :km_price
      t.decimal :km_over_price
      t.decimal :weekend_price
      t.decimal :workweek_price
      t.decimal :workday_price
      t.text :note

      t.timestamps
    end
  end
end
