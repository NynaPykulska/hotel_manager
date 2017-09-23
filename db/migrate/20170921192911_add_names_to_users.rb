class AddNamesToUsers < ActiveRecord::Migration[5.0]
  def change
    #adding the default to zero will automatically set the user access level to the first Enum attribute
    add_column :users, :name, :text
    add_column :users, :surname, :text
  end
end

