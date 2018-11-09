class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :code
      t.string :name
      t.text :note

      t.timestamps
    end
  end
end
