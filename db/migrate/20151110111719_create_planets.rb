class CreatePlanets < ActiveRecord::Migration
  def change
    create_table :planets do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :planets, :slug, unique: true
  end
end
