class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    # @page = params[:page].to_i
    # page = @page * 10
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    respond_to do |format|
      format.html { render }
      format.json { render json: @posts.select(:id, :title, :body)}
    end
    # @posts = Post.order("created_at DESC").offset(page).limit(10)
  end
  # .offset("#{current_page * per_page_count}").limit("#{per_page_count}")

  def new
    @post = Post.new
  end

  def create
    # binding.pry
    @post = Post.new(post_params)
    # we don't have access to the @current_user, but we access it through the method
    @post.user = current_user
      if @post.save
        flash[:info] = "posted!"
        redirect_to post_path(@post)
      else
        flash[:warning] = "post failure"
        render :new
      end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order("created_at DESC").page(params[:page]).per(6)
    # @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    @post.slug = nil
    # @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), flash: { info: "posted ^_^" }
    else
      flash[:warning] = "Update Not Successful -- Check Errors Below"
      render :edit
    end
  end

  def destroy
    # post = Post.find(params[:id])
    @post.delete
    redirect_to root_path, flash: { warning: "Post deleted" }
  end

  def search
    if params[:search_term]
      @search_results = Post.search_blog(params[:search_term])
    end
  end


      private

      def post_params
        params.require(:post).permit(:title, :category_id, :body, {images: []})
      end

      def find_post
        @post = Post.friendly.find(params[:id])
      end

      # def authorize_user
        # if @post.user != current_user
          # redirect_to root_path , alert: "Access Denied"
        # end
      # end

      def authorize_user
        unless can? :manage, @post
        redirect_to root_path , flash: { info: "Access Denied" }
        end
      end


end
