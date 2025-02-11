class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.belongs_to :item, null: false, foreign_key: true
      t.belongs_to :merchant, null: false, foreign_key: true
      t.belongs_to :client, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 17, scale: 2
      t.decimal :total, precision: 17, scale: 2

      t.timestamps
    end
  end
end
