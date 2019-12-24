class Api::V1::Articles::DraftsController < Api::V1::BaseApiController
  before_action :authenticate_user!, only: [:index]

  def index
    binding.pry
    articles = current_user.articles.draft
    render json: articles
  end

  def show
    article = Article.draft.find(params[:id])
    render json: article
  end

end
