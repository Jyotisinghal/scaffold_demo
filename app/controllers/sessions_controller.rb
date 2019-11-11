class SessionsController < ApplicationController
  skip_before_action :authorize
  before_action :current_user, :logged_in?, only: [:new]
  
  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	if user.try(:authenticate, params[:password])
  		session[:user_id] = user.id
      redirect_to store_index_path
  	else
  		redirect_to login_path, alert: "Invalid user/password combination"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to store_index_path, notice: "Logged out"
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
     if !current_user.nil?
      redirect_to store_index_path, notice: "you are the member of the site"
    end
  end
end
