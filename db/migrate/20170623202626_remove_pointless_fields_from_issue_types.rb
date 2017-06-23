class RemovePointlessFieldsFromIssueTypes < ActiveRecord::Migration[5.0]
  def change
  	remove_column :issue_types, :icon, :date
  	remove_column :issue_types, :when_to_resolve, :text
  	remove_attachment :issue_types, :ok_icon
    remove_attachment :issue_types, :nok_icon
  end
end
