class ChangeDataTypeForDeadline < ActiveRecord::Migration[5.0]
  def self.up
    change_table :memos do |t|
      t.change :deadline, :datetime
    end
  end
  def self.down
    change_table :memos do |t|
      t.change :fieldname, :date
    end
  end
end
