class AddPriorityToIssue < ActiveRecord::Migration[5.0]
  def change
  	add_column :issues, :priority, :text
  end
end
