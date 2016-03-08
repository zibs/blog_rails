class Api::V1::PostsController <  Api::BaseController

  def index
    @posts = Post.order("created_at ASC").limit(2)
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    # is found for us in the authenticate method
    # user = User.find_by(api_key: params[:api_key])
    post_params = params.require(:post).permit(:title, :body)
    post = Post.new(post_params)
    post.user = @user
    if post.save
      head :ok
    else
      render json:  { errors: post.errors.full_messages}
    end
  end

end
