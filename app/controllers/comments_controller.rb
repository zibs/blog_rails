class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user
  before_action :authorize_user, only: [:edit, :update, :destroy]

  # def index
  #   @comments = Comment.order("created_at DESC")
  # end
  #
  # def new
  #   @comment = Comment.new
  # end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
        if @comment.save
          format.html { PostsMailer.notify_post_owner(@comment).deliver_later
          redirect_to post_path(@post), notice: "Comment Created" }
          format.js { render :successful_comment}
        else
          format.html { render "posts/show" }
          format.js { render :unsuccessful_comment }
        end
      end
    end
  # comment_params = params.require(:comment).permit([:body])
  # @comment = Comment.new(comment_params)
  # if @comment.save
    # flash[:notice] = "Comment added successfully!"
    # redirect_to comment_path(@comment)
  # else
    # render :new
  # end
  #
  # def show
  #   # @comment = Comment.find(params[:id])
  # end
  #
  def edit
    respond_to do |format|
      format.js { render :edit_comment}
    end
  end

  #
  def update
    @post = @comment.post
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post), flash: { success: "Updated"}}
        format.js { render :successful_comment_update}
      else
        format.html { render :edit }
        format.js { render :unsuccess_comment_update}
      end
    end


  #   if @comment.update(comment_params)
  #     redirect_to comment_path(@comment)
  #   else
  #     render :edit
  #   end
  end

  def destroy
    # @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(params[:post_id]), alert: "Question Deleted" }
      format.js { render }
    end
  end

      private

      def comment_params
        params.require(:comment).permit([:body])
      end

      def find_comment
        @comment = Comment.find(params[:id])
      end

      def authorize_user
        unless ((can? :manage, @comment) || (can? :destroy, @comment) )
          redirect_to root_path, alert: "access denied"
        end
      end

end
