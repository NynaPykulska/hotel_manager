class AddIconPathToIssueType < ActiveRecord::Migration[5.0]
  def change
  	add_column :issue_types, :icon_path, :text
  end
end
