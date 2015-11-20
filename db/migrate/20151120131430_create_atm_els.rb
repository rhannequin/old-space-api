class CreateAtmEls < ActiveRecord::Migration
  def change
    create_table :atm_els do |t|
      t.string :name
      t.string :chemical_formula
      t.references :atmosphereable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
