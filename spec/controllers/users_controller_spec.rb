require 'spec_helper'
include SessionsHelper

describe UsersController do
  before(:each) do
    @attr = { :login => "NewUser", :email => "user@example.com",
              :password => "foobar", :password_confirmation => "foobar" }
  end

  it "should redirect to the new user page" do
    get :show
    response.should redirect_to(new_users_path)
  end

  #it "should allow see user profile" do
  #  user = User.new(@attr)
  #  log_in user
  #  current_user = user
  #  get :show, :format => 'js'
  #  response.should render_template("show")
  #end

  it "should create a user" do
    lambda do
      post :create, :user => @attr
    end.should change(User, :count).by(1)
  end

  it "should not create a user" do
    @attr[:password] = ""
    post :create, :user => @attr
    response.should render_template("new")
  end

  it "should render new on user signup" do
    get :new, :format => 'js'
    response.should render_template("register_form")
  end

end