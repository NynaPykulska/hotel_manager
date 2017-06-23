class RemovePointlessFieldsFromIssues < ActiveRecord::Migration[5.0]
  def change
  	remove_column :issues, :requested_fix_date, :date
  	remove_column :issues, :timestamp, :date
  	remove_column :issues, :event_id, :bigint
  end
end
