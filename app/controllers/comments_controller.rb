class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]


  def index
    @comments = Comment.order("created_at DESC")
  end

  def new
    @comment = Comment.new
  end

  def create
    comment_params = params.require(:comment).permit([:body])
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Comment added successfully!"
      redirect_to comment_path(@comment)
    else
      render :new
    end
  end

  def show
    # @comment = Comment.find(params[:id])
  end

  def edit
    # @comment = Comment.find(params[:id])
  end

  def update
    comment_params = params.require(:comment).permit([:body])
    # @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    # comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

      private

      def comment_params
        params.require(:comment).permit([:body])
      end

      def find_comment
        @comment = Comment.find(params[:id])
      end


end
