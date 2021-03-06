class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, onl: [:new, :create
  ]
  def show
    @category = Category.find_by(slug: params[:id])

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category has been created"
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @category = Category.new

  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end