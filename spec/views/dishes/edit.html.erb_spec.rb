require 'spec_helper'

describe "dishes/edit" do
  before(:each) do
    @dish = assign(:dish, stub_model(Dish,
      :name => "MyString",
      :user_id => 1,
      :location_id => 1,
      :description => "MyText",
      :restaurant_id => 1,
      :avg_points => 1,
      :no_of_ratings => 1
    ))
  end

  it "renders the edit dish form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dish_path(@dish), "post" do
      assert_select "input#dish_name[name=?]", "dish[name]"
      assert_select "input#dish_user_id[name=?]", "dish[user_id]"
      assert_select "input#dish_location_id[name=?]", "dish[location_id]"
      assert_select "textarea#dish_description[name=?]", "dish[description]"
      assert_select "input#dish_restaurant_id[name=?]", "dish[restaurent_id]"
      assert_select "input#dish_avg_points[name=?]", "dish[avg_points]"
      assert_select "input#dish_no_of_ratings[name=?]", "dish[no_of_ratings]"
    end
  end
end
