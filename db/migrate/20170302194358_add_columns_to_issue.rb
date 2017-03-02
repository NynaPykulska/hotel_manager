class AddColumnsToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :is_done, :boolean, :default => false
  end
end
