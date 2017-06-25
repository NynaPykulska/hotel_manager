class RemoveTimeStampFromMemos < ActiveRecord::Migration[5.0]
  def change
    remove_column :memos, :time_stamp, :date
  end
end
