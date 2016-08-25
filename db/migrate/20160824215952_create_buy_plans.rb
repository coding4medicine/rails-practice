class CreateBuyPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :buy_plans do |t|
      t.integer :user_id
      t.integer :plan_id
      t.datetime :request_date
      t.datetime :purchase_date
      t.datetime :end_date
      t.float :price

      t.timestamps
    end
  end
end
