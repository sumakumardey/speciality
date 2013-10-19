require 'spec_helper'

describe "dishes/index" do
  before(:each) do
    assign(:dishes, [
      stub_model(Dish,
        :name => "Name",
        :user_id => 1,
        :location_id => 2,
        :description => "MyText",
        :restaurent_id => 3,
        :avg_points => 4,
        :no_of_ratings => 5
      ),
      stub_model(Dish,
        :name => "Name",
        :user_id => 1,
        :location_id => 2,
        :description => "MyText",
        :restaurent_id => 3,
        :avg_points => 4,
        :no_of_ratings => 5
      )
    ])
  end

  it "renders a list of dishes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
