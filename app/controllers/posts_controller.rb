class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]  ##It mean the set_post methodo will be executed before these three action.
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only:[:edit, :update]
  def index
    @posts = Post.all.sort_by{|post| post.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator =  current_user #TODO: change once we have authentication
    if @post.save
      flash[:notice]= "Your post was created"
      redirect_to posts_path
    else
      render :new ## It is important to render here but not redirect becau
                   ## because the object @post contain lots of method like errors which we might use to display error back to the user.
                   ## p.s. by rendering we have access to the instance varaible
    end

  end

  def edit
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(vote:params[:vote],creator:current_user, voteable:@post)
    if @vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You can only vote on a post once"
    end
    redirect_to :back
  end

  def post_params
    params.require(:post).permit(:title,:url, :description, category_ids: []) #strong parameter syntax
  end

  def set_post
    @post = Post.find(params[:id])
  end



end
