class CreateBuyBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :buy_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :card_four
      t.float :price

      t.timestamps
    end
  end
end
