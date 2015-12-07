require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /welcomes" do
    it "works! (now write some real specs)" do
      get welcomes_path
      expect(response).to have_http_status(200)
    end
  end
end
