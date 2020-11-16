class CreateCoders < ActiveRecord::Migration[6.0]
  def change
    create_table :coders do |t|
      t.string :name
      t.string :email
      t.text :description
      t.string :phone_number
      t.integer :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
