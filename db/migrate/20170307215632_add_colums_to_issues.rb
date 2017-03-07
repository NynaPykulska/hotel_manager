class AddColumsToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :is_recurring, :boolean, :default => false
    add_column :issues, :event_id, :integer, limit: 8
  end
end
