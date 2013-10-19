require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :longitude => 1.5,
        :latitude => 1.5,
        :street => "Street",
        :city => "City",
        :state => "State",
        :country => "Country"
      ),
      stub_model(Location,
        :longitude => 1.5,
        :latitude => 1.5,
        :street => "Street",
        :city => "City",
        :state => "State",
        :country => "Country"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
  end
end
