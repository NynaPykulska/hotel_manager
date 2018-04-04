class AddIsPinnedToMemos < ActiveRecord::Migration[5.1]
  def change
    add_column :memos, :is_pinned, :boolean, default: false
  end
end
