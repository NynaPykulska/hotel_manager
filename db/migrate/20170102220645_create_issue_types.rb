class CreateIssueTypes < ActiveRecord::Migration[5.0]
  def self.up
      create_table :issue_types do |t|
         t.column :issue_type_id, :integer
         t.column :issue_desctiption, :text
         t.column :default_priority, :text
         t.column :when_to_resolve, :text
         t.column :icon, :date
      end
   end

   def self.down
      drop_table :issue_types
   end
end
