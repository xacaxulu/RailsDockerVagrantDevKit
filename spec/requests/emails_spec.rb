require 'rails_helper'

RSpec.describe "Emails", type: :request do
  describe "GET /emails" do
    it "works! (now write some real specs)" do
      get emails_path
      expect(response).to have_http_status(200)
    end
  end
end
