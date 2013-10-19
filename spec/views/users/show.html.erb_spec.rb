require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "Name",
      :twitter_id => "Twitter",
      :facebook_id => "Facebook",
      :location_id => 1,
      :no_of_ratings => 2,
      :no_of_reviews => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Twitter/)
    rendered.should match(/Facebook/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
