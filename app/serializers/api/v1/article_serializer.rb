# frozen_string_literal: true

class Api::V1::ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :updated_at, :status
  belongs_to :user
end
