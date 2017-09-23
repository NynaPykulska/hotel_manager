class AddMissingColumns < ActiveRecord::Migration[5.0]
  def change
  	add_column :memos, :author, :string
  	add_column :issues, :reporter, :string
  	add_column :issues, :resolver, :string
  end
end
