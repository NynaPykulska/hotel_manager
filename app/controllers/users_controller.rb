class UsersController < ApplicationController
	  
  protect_from_forgery with: :null_session
  
  before_action do
    require_login("admin")
  end

  def list
    @roles_pl = Hash["admin" => "Administracja", "receptionist" => "Recepcja", "maid" => "Sprzątanie", "maitenance" => "Utrzymanie"]
    @users = User.all
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
    @user = User.find(params[:id])
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