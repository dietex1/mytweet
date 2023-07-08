class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "You've logged in!"
        redirect_to root_path
    else
        flash[:alert] = "There was something wrong with your login details"
        render :new
    end
  end
  def destroy
     session[:user_id] = nil
     flash[:notice] = "You've logged out!"
     redirect_to root_path
  end
end