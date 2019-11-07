class UsersController < ApplicationController
  skip_before_action :authorize
	
	def index
		@users = User.order(:name)
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html { redirect_to users_url,
					notice: "User #{@user.name} was successfully created." }
			else
				format.html {render :new}
			end
		end
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to users_url,
					notice: "User #{@user.name} was successfully updaated."}
			else
				format.html { render :edit}
			end
		end
	end

	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to users_path, notice: "User #{@user.name} deleted"}
		end
	end

	rescue_from 'User::Error' do |e|
		redirect_to users_path, notice: e.message
	end

	private

	def user_params
		params.require(:user).permit(:name, :password)
	end

end
