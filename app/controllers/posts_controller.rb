class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.feed
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      flash.now[:danger] = "There was a problem creating the post. Please try again."
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated."
      redirect_to @post
    else
      flash.now[:danger] = "Couldn't update post - try again."
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:content, :user_id)
    end
  
end
