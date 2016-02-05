class PostsController < ApplicationController
  before_action :find_post only: [:show, :edit, :update, :destroy]

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
    if @post.save
      flash[:notice] = "posted!"
      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def show
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
      render :edit
    end
  end

  def destroy
    # post = Post.find(params[:id])
    @post.delete
    redirect_to root_path[]
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


end
