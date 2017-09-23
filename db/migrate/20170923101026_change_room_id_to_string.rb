class ChangeRoomIdToString < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :room_id, :text, :limit => 64
    change_column :issues, :room_id, :text, :limit => 64
    change_column :memos, :room_id, :text, :limit => 64
  end
end
