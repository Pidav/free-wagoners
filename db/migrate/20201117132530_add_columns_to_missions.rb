class AddColumnsToMissions < ActiveRecord::Migration[6.0]
  def change
    add_column :missions, :title, :string
    add_column :missions, :description, :text
  end
end
