class SessionsController < ApplicationController
  # not creating a `new` model, so don't need to put anything in the new action
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # this sets the user's session
      sign_in(user)
      redirect_to root_path, notice: "Successfully Signed In..."
    else
      flash[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully signed out..."
  end

end
