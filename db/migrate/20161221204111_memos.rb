class Memos < ActiveRecord::Migration[5.0]
  def self.up
      create_table :memos do |t|
         t.column :room_id, :integer
         t.column :description, :text
         t.column :deadline, :date
         t.column :completion_date, :date
         t.column :time_stamp, :date
         t.column :is_done, :boolean
      end
   end

   def self.down
      drop_table :memos
   end
end