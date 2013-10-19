require 'spec_helper'

describe "locations/edit" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :longitude => 1.5,
      :latitude => 1.5,
      :street => "MyString",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString"
    ))
  end

  it "renders the edit location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", location_path(@location), "post" do
      assert_select "input#location_longitude[name=?]", "location[longitude]"
      assert_select "input#location_latitude[name=?]", "location[latitude]"
      assert_select "input#location_street[name=?]", "location[street]"
      assert_select "input#location_city[name=?]", "location[city]"
      assert_select "input#location_state[name=?]", "location[state]"
      assert_select "input#location_country[name=?]", "location[country]"
    end
  end
end
