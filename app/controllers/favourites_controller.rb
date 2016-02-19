class FavouritesController < ApplicationController
  before_action :authenticate_user

  def index
    @favourites = current_user.favourited_questions.order("created_at DESC")
  end

  def create
    post = Post.find(params[:post_id])
    favourite = Favourite.new(post: post, user: current_user)
    if favourite.save
      redirect_to post, flash: { success: "<3"}
    else
      redirect_to post, flash: { info: "already <3ed"}
    end
  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.destroy
    redirect_to post_path(params[:post_id]), flash: {warning: "un<3ed"}
  end

end
