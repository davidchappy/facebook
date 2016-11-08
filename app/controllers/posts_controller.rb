class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(user_id: current_user.id)
  end
  
end
