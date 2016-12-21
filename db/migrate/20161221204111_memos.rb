class Memos < ActiveRecord::Migration[5.0]
  def self.up
      create_table :memos do |t|
         t.column :room_number, :integer
         t.column :description, :text
         t.column :completion_date, :date
      end
   end

   def self.down
      drop_table :memos
   end
end