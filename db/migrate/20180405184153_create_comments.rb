class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :memo_id
      t.integer :user_id
      t.string :username
      t.date :date
      t.text :comment_text

      t.timestamps
    end
  end
end
