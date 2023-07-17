class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_request, only: [:new, :create]
  before_action :authorize_admin, only: [:edit, :update, :destroy]

  def index
    @news = News.all
  end

  def show
    @comments = @news.comments
    @comment = Comment.new
  end

  def new
    @news = News.new
  end

  def edit
  end

  def create
    @news = current_user.news.build(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: "News was successfully created." }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: "News was successfully updated." }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url, notice: "News was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :content, :user_id)
  end

  def authorize_request
    redirect_to root_url, alert: "You are not authorized to perform this action." unless current_user.author? || current_user.admin?
  end

  def authorize_admin
    redirect_to root_url, alert: "You are not authorized to perform this action." unless current_user.admin?
  end
end
