class Admin::NewsController < ApplicationController
  before_action :load_categories, only: [:new, :create, :index, :edit]
  before_action :load_news, only: [:edit, :update, :destroy, :show]

  def index
    # @results_quantity = News.search(params[:search]).in_category(params[:category_id]).count
    @search = News.ransack(params[:q])
    @results_quantity = @search.result.count
    @news = @search.result.order(created_at: :desc)
      .page(params[:page]).per Settings.admin.news.per_page
  end

  def show
  end

  def new
    @news = News.new
  end

  def edit
    params[:category_id] = @news.category_id
  end

  def create
    @news = News.new news_params
    if @news.save
      flash[:success] = "Create news success"
      redirect_to admin_news_index_url
    else
      render :new
    end
  end

  def update
    if @news.update_attributes news_params
      flash[:success] = "Update news success"
      redirect_to admin_news_index_url
    else
      render :edit
    end
  end

  def destroy
    if @news.destroy
      flash[:success] = "Delete news success"
    else
      flash[:danger] = "Fail to delete news"
    end
    redirect_to admin_news_index_url
  end

  private
  def news_params
    params.require(:news).permit :title, :content, :author, :category_id
  end

  def load_categories
    @categories = Category.all
  end

  def load_news
    @news = News.find_by id: params[:id]
    if @news.nil?
      flash[:danger] = "Cannot found news"
      redirect_to admin_news_index_url
    end
  end
end
