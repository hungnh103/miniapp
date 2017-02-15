class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:edit, :update, :destroy, :show]
  def index
    # if params[:search]
    #   @results_quantity = Category.search(params[:search]).count
    #   @categories = Category.search(params[:search]).order(created_at: :desc)
    #     .page(params[:page]).per Settings.admin.category.per_page
    # else
    #   @categories = Category.order(created_at: :desc)
    #     .page(params[:page]).per Settings.admin.category.per_page
    # end
    @search = Category.ransack(params[:q])
    @results_quantity = @search.result.count
    @categories = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.admin.category.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Add category success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Update cate success"
    else
      flash[:danger] = "Update cate failed"
    end
    redirect_to admin_categories_url
  end

  def destroy
    if @category.news.any?
      flash[:danger] = "Cannot delete category has any news"
    else
      if @category.destroy
        flash[:success] = "Delete cate success"
      else
        flash[:danger] = "Delete cate failed"
      end
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = "Cannot find category"
      redirect_to admin_categories_url
    end
  end
end
