require 'rails_helper'

RSpec.describe "emails/index", type: :view do
  before(:each) do
    assign(:emails, [
      Email.create!(
        :address => "MyText"
      ),
      Email.create!(
        :address => "MyText"
      )
    ])
  end

  it "renders a list of emails" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
