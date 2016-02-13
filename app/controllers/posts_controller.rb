class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @page = params[:page].to_i
    page = @page * 10
    @posts = Post.order("created_at DESC").offset(page).limit(10)
  end
  # .offset("#{current_page * per_page_count}").limit("#{per_page_count}")

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # we don't have access to the @current_user, but we access it through the method
    @post.user = current_user
      if @post.save
        flash[:notice] = "posted!"
        redirect_to posts_path(@post)
      else
        flash[:alert] = "post failure"
        render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order("created_at DESC")
    # @post = Post.find(params[:id])
  end

  def edit
    # @post = Post.find(params[:id])
  end

  def update

    # @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post not created -- Check errors below"
      render :edit
    end
  end

  def destroy
    # post = Post.find(params[:id])
    @post.delete
    redirect_to root_path, alert: "Post deleted"
  end

  def search
    if params[:search_term]
      @search_results = Post.search_blog(params[:search_term])
    end
  end


      private

      def post_params
        params.require(:post).permit([:title, :body])
      end

      def find_post
        @post = Post.find(params[:id])
      end

      def authenticate_user
        redirect_to new_session_path, notice: "Please sign in :) " unless user_signed_in?
      end

      # def authorize_user
        # if @post.user != current_user
          # redirect_to root_path , alert: "Access Denied"
        # end
      # end
      def authorize_user
        unless can? :manage, @question
        redirect_to root_path , alert: "Access Denied"
        end
      end


end
