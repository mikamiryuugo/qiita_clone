# frozen_string_literal: true

class Article < ApplicationRecord
  enum status: { published: 0, draft: 1 }
  belongs_to :user
  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
