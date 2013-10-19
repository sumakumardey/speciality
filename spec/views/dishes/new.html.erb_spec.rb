require 'spec_helper'

describe "dishes/new" do
  before(:each) do
    assign(:dish, stub_model(Dish,
      :name => "MyString",
      :user_id => 1,
      :location_id => 1,
      :description => "MyText",
      :restaurant_id => 1,
      :avg_ratings => 1,
      :no_of_ratings => 1
    ).as_new_record)
  end

  it "renders new dish form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dishes_path, "post" do
      assert_select "input#dish_name[name=?]", "dish[name]"
      assert_select "input#dish_user_id[name=?]", "dish[user_id]"
      assert_select "input#dish_location_id[name=?]", "dish[location_id]"
      assert_select "textarea#dish_description[name=?]", "dish[description]"
      assert_select "input#dish_restaurant_id[name=?]", "dish[restaurent_id]"
      assert_select "input#dish_avg_ratings[name=?]", "dish[avg_ratings]"
      assert_select "input#dish_no_of_ratings[name=?]", "dish[no_of_ratings]"
    end
  end
end
