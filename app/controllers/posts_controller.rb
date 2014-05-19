class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]  ##It mean the set_post methodo will be executed before these three action.

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)
    @post.creator =  User.first #TODO: change once we have authentication
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

  def post_params
    params.require(:post).permit(:title,:url, :description) #permite everything
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
