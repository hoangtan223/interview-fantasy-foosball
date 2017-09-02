class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        login(user)
        redirect_to root_path, flash: {success: "Logged in!"}
      else
        flash[:error] = "Invalid password."
        render 'new'
      end
    else
      flash[:error] = "Invalid email."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: {success: "Signed out successfully!"}
  end
end
