require 'spec_helper'

describe "comments/new" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :content => "MyString",
      :user_id => "",
      :status_id => "",
      :reply_comment_id => ""
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", comments_path, "post" do
      assert_select "input#comment_content[name=?]", "comment[content]"
      assert_select "input#comment_user_id[name=?]", "comment[user_id]"
      assert_select "input#comment_status_id[name=?]", "comment[status_id]"
      assert_select "input#comment_reply_comment_id[name=?]", "comment[reply_comment_id]"
    end
  end
end
