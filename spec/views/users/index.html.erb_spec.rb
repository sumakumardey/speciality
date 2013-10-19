require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :name => "Name",
        :twitter_id => "Twitter",
        :facebook_id => "Facebook",
        :location_id => 1,
        :no_of_ratings => 2,
        :no_of_reviews => 3
      ),
      stub_model(User,
        :name => "Name",
        :twitter_id => "Twitter",
        :facebook_id => "Facebook",
        :location_id => 1,
        :no_of_ratings => 2,
        :no_of_reviews => 3
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
