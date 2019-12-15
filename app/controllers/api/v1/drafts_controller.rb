class Api::V1::DraftsController < Api::V1::BaseApiController
  before_action :authenticate_user!, only: [:index]

  def index
    articles = current_user.articles.where(status: 0)
    render json: articles
  end


end
