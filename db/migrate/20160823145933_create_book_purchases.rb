class CreateBookPurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :book_purchases do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :card_id
      t.datetime :purchase_date
      t.float :price

      t.timestamps
    end
  end
end
