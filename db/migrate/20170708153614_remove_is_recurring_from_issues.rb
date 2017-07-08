class RemoveIsRecurringFromIssues < ActiveRecord::Migration[5.0]
  def change
    remove_column :issues, :is_recurring, :boolean
  end
end
