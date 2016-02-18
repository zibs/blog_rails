class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :edit_password, :update_password, :show, :destroy]
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, flash: { info: "Account Created :)"}
    else
      flash[:warning] = "Not quite! Review the errors and retry."
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, flash: { success: "Update Successful" }
    else
      render :edit
    end
  end

  def edit_password
  end

  def update_password
    if (@user.authenticate(user_params[:current_password])) && (user_params[:password] == user_params[:password_confirmation]) && @user.update(password: user_params[:password])
        redirect_to root_path, flash: { success: "Password Recodified ..." }
    else
      flash[:warning] = "Invalid Email/Password Combination"
      render :edit_password
    end
  end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation, :current_password])
    end

end
