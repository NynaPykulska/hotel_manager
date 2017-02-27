class Issues < ActiveRecord::Migration[5.0]
  def self.up
      create_table :issues do |t|
         t.column :room_id, :integer
         t.column :issue_type_id, :integer
         t.column :requested_fix_date, :date
         t.column :fix_comment, :text
         t.column :timestamp, :date
         t.column :completion_date, :date
         t.column :priority, :text
      end
   end

   def self.down
      drop_table :issues
   end
end
