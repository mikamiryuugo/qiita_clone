require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "正常系" do
    let!(:user) {create(:user)}
    let!(:article)  { create(:article, user_id: user.id) }
    let!(:article2) { create(:article, :with_published_article, user_id: user.id) }

    context "statusカラムの値が「published」のレコードを検索した時" do
      it "公開記事が返される" do
        expect(Article.published.count).to eq 1
      end
    end

    context "statusカラムの値が「draft」の記事を指定した時" do
      it "下書き記事が返される" do
        expect(Article.draft.count).to eq 1
      end
    end

  end
end
