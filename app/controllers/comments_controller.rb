class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :destroy]
  before_action :load_news_comments, only: [:show]

  def load_news_comments
    @news = News.find(params[:news_id])
    @comments = @news.comments
  end
  
  def show
    @news = News.find(params[:news_id])
    @comments = @news.comments
    @comment = Comment.find(params[:id])
  end
  

  def create
    @news = News.find(params[:news_id])
    @comment = @news.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @news, notice: "Comment was successfully created."
    else
      redirect_to @news, alert: "Failed to create comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @news = @comment.news
  
    if current_user.admin? || current_user == @comment.user
      @comment.destroy
      redirect_to @news, notice: "Comment was successfully deleted."
    else
      redirect_to @news, alert: "You are not authorized to delete this comment."
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
