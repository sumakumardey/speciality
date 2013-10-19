require 'spec_helper'

describe "dishes/show" do
  before(:each) do
    @dish = assign(:dish, stub_model(Dish,
      :name => "Name",
      :user_id => 1,
      :location_id => 2,
      :description => "MyText",
      :restaurent_id => 3,
      :avg_points => 4,
      :no_of_ratings => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
