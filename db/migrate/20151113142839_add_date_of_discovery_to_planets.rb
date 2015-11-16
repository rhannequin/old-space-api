class AddDateOfDiscoveryToPlanets < ActiveRecord::Migration
  def change
    add_column :planets, :date_of_discovery, :string
  end
end
