class CreateForecasts < ActiveRecord::Migration[7.2]
  def change
    create_table :forecasts do |t|
      t.string :kind
      t.integer :current_temp
      t.integer :high_temp
      t.integer :low_temp
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
