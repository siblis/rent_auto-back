class CreateManufacturers < ActiveRecord::Migration[5.2]
  def change
    create_table :manufacturers do |t|
      t.string :code
      t.string :name
      t.references :brand, foreign_key: true
      t.references :country, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
