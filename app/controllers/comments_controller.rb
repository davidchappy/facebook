class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment added."
      redirect_to @comment.post
    else
      flash.now[:danger] = "Couldn't create comment - try again."
      render @comment.post
    end
  end

  def update
  end

  def destroy
  end

  private 

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
