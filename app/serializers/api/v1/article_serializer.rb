# frozen_string_literal: true

class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :updated_at, :status
  belongs_to :user
end
