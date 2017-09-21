class UsersController < ApplicationController
	  
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def list
    @roles_pl = Hash["admin" => "Administracja", "receptionist" => "Recepcja", "maid" => "Sprzątanie", "maitenance" => "Utrzymanie"]
    @users = User.all
    # Add tabs for user types
    #@users.each do |m|
    #  m.is_done ? @done+=1 : @not_done+=1
    #end
  end

  def create_new_user
    User.create!({:email => params[:user][:email],
                  :password => params[:user][:password],
                  :name => params[:user][:name],
                  :username => params[:user][:username],
                  :surname => params[:user][:surname],
                  :role => params[:user][:role]
                })
    redirect_back(fallback_location: root_path)
  end

  def edit
    @c = User.find(params[:id])
  end
   
  def update
    puts "xaxa1"
    @user = User.find(params[:id])
    puts "xaxa"
    @user.update_attributes(user_params)
    redirect_back(fallback_location: root_path)
  end

  def delete
    User.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :name, :username, :surname, :role)
  end

end
