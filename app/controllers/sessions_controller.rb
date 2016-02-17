class SessionsController < ApplicationController
  # not creating a `new` model, so don't need to put anything in the new action
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      session["#{user.email}"] = nil
      redirect_to root_path, flash: { success: "Logged In ^_^" }
    else
      flash[:warning] = "Invalid Email/Password Combination"
      if user
        session["#{user.email}"] ||= 0
        if session["#{user.email}"] >= 10
          redirect_to new_password_reset_path
        else
          session["#{user.email}"] += 1
          render :new
        end
      else
        render :new
      end
    end
  end



  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { warning: "Successfully signed out..." }
  end

end
