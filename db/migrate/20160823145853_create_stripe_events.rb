class CreateStripeEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :stripe_events do |t|
      t.string :event

      t.timestamps
    end
  end
end
