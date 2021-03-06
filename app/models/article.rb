# frozen_string_literal: true

class Article < ApplicationRecord
  enum status: { draft: "draft", published: "published" }
  belongs_to :user
  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
