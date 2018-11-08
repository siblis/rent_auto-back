class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :code
      t.string :name
      t.references :brand, foreign_key: true
      t.references :manufacture, foreign_key: true
      t.references :body_type, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
