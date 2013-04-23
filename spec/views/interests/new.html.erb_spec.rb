require 'spec_helper'

describe "interests/new" do
  before(:each) do
    assign(:interest, stub_model(Interest,
      :user_id => 1,
      :topic_id => 1
    ).as_new_record)
  end

  it "renders new interest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", interests_path, "post" do
      assert_select "input#interest_user_id[name=?]", "interest[user_id]"
      assert_select "input#interest_topic_id[name=?]", "interest[topic_id]"
    end
  end
end
