class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post= Post.find_by(slug: params[:post_id]) #comment is a nested object with parent object post.
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
    @comment = Comment.find(params[:id])
    @vote = Vote.create(vote:params[:vote],creator:current_user, voteable:@comment)


    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You can only vote on a post once"
        end
        redirect_to :back  
      end      
      format.js
    end
  end

end