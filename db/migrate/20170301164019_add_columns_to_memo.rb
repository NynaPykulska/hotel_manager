class AddColumnsToMemo < ActiveRecord::Migration[5.0]
  def change
    add_column :memos, :is_recurring, :boolean, :default => false
    add_column :memos, :event_id, :text
  end
end
