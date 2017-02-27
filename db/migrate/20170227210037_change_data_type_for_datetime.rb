class ChangeDataTypeForDatetime < ActiveRecord::Migration[5.0]
  def change
  	change_table :memos do |t|
      t.change :deadline, :datetime
      t.change :time_stamp, :datetime
    end
  end
end
