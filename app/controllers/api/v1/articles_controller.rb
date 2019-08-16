class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy]

  def index
    articles = Article.all
    render json: articles
  end

  def create
    article = current_user.articles.create!(article_params)
    render json: article
  end

  def update
    @article.update!(article_params)
    render json: @article
  end

  def destroy
    @article.destroy!
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end


end
