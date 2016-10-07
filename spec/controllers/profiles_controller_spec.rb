require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "Instructor Profile" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
