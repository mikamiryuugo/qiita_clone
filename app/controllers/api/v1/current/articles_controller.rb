# frozen_string_literal: true

class Api::V1::Current::ArticlesController < Api::V1::BaseApiController
  before_action :authenticate_user!, only: %i[index]

  def index
    articles = current_user.articles.published
    render json: articles
  end

end
