class Api::V1::ArticlesController < ApplicationController

  def index
    articles = Article.all
    render json: articles
  end

  def create
    article = current_user.articles.build(article_params)
    article.save!
    render json: article
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
