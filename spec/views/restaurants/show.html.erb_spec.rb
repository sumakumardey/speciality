require 'spec_helper'

describe "restaurants/show" do
  before(:each) do
    @restaurant = assign(:restaurant, stub_model(Restaurant,
      :name => "Name",
      :location_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
