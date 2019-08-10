class Api::V1::ArticlesController < ApplicationController

  def index
    articles = Article.all
    render json: articles
  end

  def create
    article = current_user.articles.create!(article_params)
    render json: article
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
