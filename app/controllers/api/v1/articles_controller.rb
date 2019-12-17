# frozen_string_literal: true

class Api::V1::ArticlesController < Api::V1::BaseApiController
  before_action :set_article, only: %i[update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    articles = Article.all.where(status: "published")
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: article if article.published?
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
    params.require(:article).permit(:title, :content, :status)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end
