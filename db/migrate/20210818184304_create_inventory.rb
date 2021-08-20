class CreateInventory < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.string :barcode, null: false, limit: 25
      t.string :serial_no, null: false, limit: 25
      t.string :name, null: false, default: '', limit: 100
      t.string :description, null: false, limit: 250
      t.date :purchase_date, null: false
      t.decimal :price, null: false, default: 0
      t.integer :quantity, null: false, default: 1
      t.references :creator, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
