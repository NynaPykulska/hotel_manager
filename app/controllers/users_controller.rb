class UsersController < ApplicationController
	  
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def list
    @users = User.all
    # Add tabs for user types
    #@users.each do |m|
    #  m.is_done ? @done+=1 : @not_done+=1
    #end
  end

  def create_new_user
    User.create!({:email => params[:user][:email],
                  :password => params[:user][:password], 
                  :password_confirmation => params[:user][:password],
                  :name => params[:user][:name],
                  :username => params[:user][:username],
                  :surname => params[:user][:surname],
                  :role => params[:user][:role]
                })
    redirect_back(fallback_location: root_path)
  end

end
