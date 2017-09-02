class UsersController < ApplicationController
  before_action :require_login, only: [:index]
  def index
    @users = User.all_except(current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to root_path, flash: {success: "User created!"}
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
