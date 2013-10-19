require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :name => "MyString",
      :twitter_id => "MyString",
      :facebook_id => "MyString",
      :location_id => 1,
      :no_of_ratings => 1,
      :no_of_reviews => 1
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_name[name=?]", "user[name]"
      assert_select "input#user_twitter_id[name=?]", "user[twitter_id]"
      assert_select "input#user_facebook_id[name=?]", "user[facebook_id]"
      assert_select "input#user_location_id[name=?]", "user[location_id]"
      assert_select "input#user_no_of_ratings[name=?]", "user[no_of_ratings]"
      assert_select "input#user_no_of_reviews[name=?]", "user[no_of_reviews]"
    end
  end
end
