class CreateSshkeys < ActiveRecord::Migration[5.0]
  def change
    create_table :sshkeys do |t|
      t.integer :user_id
      t.string :key

      t.timestamps
    end
  end
end
