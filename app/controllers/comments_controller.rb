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

  def vote
    #note that vote is not model-backed. We dont use instance variable and therefore not use render.
    @vote = Vote.create(vote:params[:vote],creator:current_user, voteable:Comment.find(params[:id]))
    if @vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You can only vote on a post once"
    end
    redirect_to :back
  end

end