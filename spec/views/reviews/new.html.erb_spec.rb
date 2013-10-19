require 'spec_helper'

describe "reviews/new" do
  before(:each) do
    assign(:review, stub_model(Review,
      :description => "MyText",
      :dish_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new review form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reviews_path, "post" do
      assert_select "textarea#review_description[name=?]", "review[description]"
      assert_select "input#review_dish_id[name=?]", "review[dish_id]"
      assert_select "input#review_user_id[name=?]", "review[user_id]"
    end
  end
end
