class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_id
      t.float :price
      t.datetime :interval
      t.boolean :visible

      t.timestamps
    end
  end
end
