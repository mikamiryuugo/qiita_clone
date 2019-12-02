require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject { get(api_v1_articles_path) }

    let(:article_count) { 5 }
    before do
      create(:user, :with_articles, article_count: article_count)
    end

    it "articlesの一覧を取得できる" do
      subject
      res = JSON.parse(response.body).count
      expect(res).to eq article_count
    end
  end

  describe "POST /api/v1/articles" do
    subject { post(api_v1_articles_path, params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:params) { { article: attributes_for(:article) } }
    let(:headers) { authentication_headers_for(current_user) }

    it "articleのレコードが作成できる" do
      aggregate_failures do
        expect { subject }.to change { current_user.articles.count }.by(1)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PATCH /api/v1/articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }
    let(:params) { { article: attributes_for(:article) } }

    context "自分の記事のレコードを更新しようとするとき" do
      let!(:article) { create(:article, user_id: current_user.id) }
      it "articleのレコードが更新できる" do
        aggregate_failures do
          expect { subject }.to change { Article.find(article.id).title }.from(article.title).to(params[:article][:title]) &
                                change { Article.find(article.id).content }.from(article.content).to(params[:article][:content])
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  describe "DELETE /api/v1/articles/:id" do
    subject { delete(api_v1_article_path(article.id)) }

    let!(:article) { create(:article, user_id: current_user.id) }
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }

    context "自分の記事のレコードを削除するとき" do
      it "articleのレコードを削除できる" do
        expect { subject }.to change { current_user.articles.count }.by(-1)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
