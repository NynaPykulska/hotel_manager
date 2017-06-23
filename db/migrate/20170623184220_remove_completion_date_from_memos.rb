class RemoveCompletionDateFromMemos < ActiveRecord::Migration[5.0]
  def change
    remove_column :memos, :completion_date, :date
  end
end
