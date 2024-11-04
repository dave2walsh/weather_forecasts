class AddIndexToAddress < ActiveRecord::Migration[7.2]
  def change
    add_index :addresses, [:city, :state, :zip_code], unique: true
  end
end
