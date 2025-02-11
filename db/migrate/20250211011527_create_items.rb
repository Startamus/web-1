class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :description, null: false
      #t.decimal :price, precision: 17, scale: 2
      #NOTE: Not adding price to 'items' because two items with the same name in the data have different prices, so it's going in 'sales '

      t.timestamps
    end
  end
end
