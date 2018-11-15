# db/migrate/20181108123659_create_regions.rb
class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions, comment: 'Спраовчник областей' do |t|
      t.string :code
      t.string :name
      t.references :state, foreign_key: true
      t.references :country, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
