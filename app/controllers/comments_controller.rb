class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post= Post.find(params[:post_id]) #comment is a nested object with parent object post.
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator =  current_user #TODO: change once we have authentication
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

  end
end