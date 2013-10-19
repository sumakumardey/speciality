require 'spec_helper'

describe "restaurants/edit" do
  before(:each) do
    @restaurant = assign(:restaurant, stub_model(Restaurant,
      :name => "MyString",
      :location_id => 1
    ))
  end

  it "renders the edit restaurant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", restaurant_path(@restaurant), "post" do
      assert_select "input#restaurant_name[name=?]", "restaurant[name]"
      assert_select "input#restaurant_location_id[name=?]", "restaurant[location_id]"
    end
  end
end
