class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
  	#adding the default to zero will automatically set the user access level to the first Enum attribute
   	add_column :users, :role, :integer, default: 0
  end
end

