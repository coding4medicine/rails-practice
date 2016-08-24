class CreateReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals do |t|
      t.string :OldEmail
      t.string :NewEmail
      t.integer :old_id
      t.integer :new_id
      t.boolean :bonuspaid

      t.timestamps
    end
  end
end
