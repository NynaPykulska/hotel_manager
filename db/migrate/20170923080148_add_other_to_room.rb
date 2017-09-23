class AddOtherToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :is_other, :boolean, :default => false
  end
end
