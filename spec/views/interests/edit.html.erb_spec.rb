require 'spec_helper'

describe "interests/edit" do
  before(:each) do
    @interest = assign(:interest, stub_model(Interest,
      :user_id => 1,
      :topic_id => 1
    ))
  end

  it "renders the edit interest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", interest_path(@interest), "post" do
      assert_select "input#interest_user_id[name=?]", "interest[user_id]"
      assert_select "input#interest_topic_id[name=?]", "interest[topic_id]"
    end
  end
end
