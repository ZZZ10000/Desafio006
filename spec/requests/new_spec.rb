require 'rails_helper'

RSpec.describe "News", type: :request do
  # Test para la acción index
  describe "GET /index" do
    it "returns a successful response" do
      get news_index_path
      expect(response).to have_http_status(:success)
    end
  end

  # Test para la acción show
  describe "GET /show" do
    let(:news) { News.create(title: "Noticia de prueba", content: "Contenido de la noticia de prueba") }

    it "returns a successful response" do
      get news_path(news)
      expect(response).to have_http_status(:success)
    end
  end

  # Test para la acción new
  describe "GET /new" do
    it "renders the new template" do
      get new_news_path
      expect(response).to render_template(:new)
    end
  end

  # Test para la acción create
  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new news item and redirects to the show page" do
        post news_index_path, params: { news: { title: "Nueva Noticia", content: "Contenido de la nueva noticia" } }
        expect(response).to redirect_to(assigns(:news))
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include("Nueva Noticia")
      end
    end

    context "with invalid parameters" do
      it "does not create a news item and re-renders the new template" do
        post news_index_path, params: { news: { title: "", content: "" } }
        expect(response).to render_template(:new)
      end
    end
  end
end
