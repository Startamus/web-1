class CreateMerchants < ActiveRecord::Migration[7.1]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :address

      t.timestamps
    end
  end
end
