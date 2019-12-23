class Api::V1::DraftsController < Api::V1::BaseApiController
  before_action :authenticate_user!, only: [:index]

  def index
    articles = current_user.articles.draft
    render json: articles
  end

  def show
    article = Article.draft.find(params[:id])
    render json: article
  end

end
