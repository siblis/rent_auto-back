class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :code
      t.string :name
      t.references :brand, foreign_key: true
      t.references :manufacture, foreign_key: true
      t.references :body_type, foreign_key: true
      t.boolean :active, default: true
      t.string :door_count
      t.string :seat_count
      t.string :style
      t.string :transmission
      t.string :drive_type
      t.string :fuel_type
      t.string :engine
      t.float :engine_volume
      t.string :options, array: true
      t.text :note

      t.timestamps
    end
  end
end
