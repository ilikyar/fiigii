require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "MyString",
      :email => "MyString",
      :descript => "MyText",
      :url => "MyString",
      :gender => "MyString",
      :remember_token => "MyString",
      :admin => false
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_name[name=?]", "user[name]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "textarea#user_descript[name=?]", "user[descript]"
      assert_select "input#user_url[name=?]", "user[url]"
      assert_select "input#user_gender[name=?]", "user[gender]"
      assert_select "input#user_remember_token[name=?]", "user[remember_token]"
      assert_select "input#user_admin[name=?]", "user[admin]"
    end
  end
end
