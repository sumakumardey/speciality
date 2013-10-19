require 'spec_helper'

describe "reviews/show" do
  before(:each) do
    @review = assign(:review, stub_model(Review,
      :description => "MyText",
      :dish_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
