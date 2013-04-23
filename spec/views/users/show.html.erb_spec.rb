require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "Name",
      :email => "Email",
      :descript => "MyText",
      :url => "Url",
      :gender => "Gender",
      :remember_token => "Remember Token",
      :admin => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/MyText/)
    rendered.should match(/Url/)
    rendered.should match(/Gender/)
    rendered.should match(/Remember Token/)
    rendered.should match(/false/)
  end
end
