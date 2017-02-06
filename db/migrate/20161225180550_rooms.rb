class Rooms < ActiveRecord::Migration[5.0]
  def self.up
      create_table :rooms do |t|
         t.column :room_id, :integer, :primary_key
         t.column :description, :text
         t.column :is_clean, :boolean
      end
   end

   def self.down
      drop_table :rooms
   end
end
