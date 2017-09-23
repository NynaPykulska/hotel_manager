class AddAuthorColumnToMemo < ActiveRecord::Migration[5.0]
  def change
  	add_column :issues, :report_date, :date
  end
end
