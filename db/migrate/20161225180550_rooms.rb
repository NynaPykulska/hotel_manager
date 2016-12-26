class Rooms < ActiveRecord::Migration[5.0]
  def self.up
      create_table :rooms do |t|
         t.column :number, :integer
         t.column :description, :text
      end
   end

   def self.down
      drop_table :rooms
   end
end
