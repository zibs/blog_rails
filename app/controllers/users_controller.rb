class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Account Created :)"
    else
      flash[:alert] = "Account sign up failed "
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Updated Successfully"
    else
      render :edit
    end
  end



    private

    def find_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation])
    end
end
