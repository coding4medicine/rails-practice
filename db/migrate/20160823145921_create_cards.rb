class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :stripe_token
      t.integer :user_id
      t.integer :last4

      t.timestamps
    end
  end
end
