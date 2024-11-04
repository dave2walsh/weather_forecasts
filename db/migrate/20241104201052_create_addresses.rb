class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
