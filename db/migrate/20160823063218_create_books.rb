class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :image
      t.float :price
      t.boolean :visible

      t.timestamps
    end
  end
end
