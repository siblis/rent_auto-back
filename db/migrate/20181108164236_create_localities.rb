class CreateLocalities < ActiveRecord::Migration[5.2]
  def change
    create_table :localities do |t|
      t.string :code
      t.string :name
      t.references :status, foreign_key: true
      t.references :region, foreign_key: true
      t.references :state, foreign_key: true
      t.references :country, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
