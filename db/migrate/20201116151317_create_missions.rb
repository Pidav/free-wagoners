class CreateMissions < ActiveRecord::Migration[6.0]
  def change
    create_table :missions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coder, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :total_price
      t.boolean :validated_mission

      t.timestamps
    end
  end
end
