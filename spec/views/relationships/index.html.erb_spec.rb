require 'spec_helper'

describe "relationships/index" do
  before(:each) do
    assign(:relationships, [
      stub_model(Relationship,
        :follower_id => "",
        :followed_id => ""
      ),
      stub_model(Relationship,
        :follower_id => "",
        :followed_id => ""
      )
    ])
  end

  it "renders a list of relationships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
