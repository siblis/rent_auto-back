# db/migrate/20181108123412_create_states.rb
class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states, comment: 'Справочник округов' do |t|
      t.string :code
      t.string :name
      t.references :country, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
