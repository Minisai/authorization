require 'spec_helper'

describe User do
  describe "Test validations" do
    before { @user = User.new(login: "Login", email: "user@example.com", password: "123456") }

    subject { @user }

    it { should respond_to(:login) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should be_valid}

    # Login validation tests
    describe "when login is not present" do
      before { @user.login = " " }
      it { should_not be_valid }
    end

    describe "when login is too large" do
      before { @user.login = "qwertyuiopasdfghjklzxcvbnmqwertyuioqwertyuiopasdfghjkzxcvbnmasdfghjk" }
      it { should_not be_valid }
    end

    describe "when login is too small" do
      before { @user.login = "pf"}
      it { should_not be_valid }
    end

    # Email validation tests
    describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end

    describe "when email is wrong format #1" do
      before { @user.email = "kokoko.tut.by" }
      it { should_not be_valid }
    end

    describe "when email is wrong format #2" do
      before { @user.email = "kokoko@@tut.by"}
      it { should_not be_valid }
      end
  end
  # Create user with omniauth test
  describe "Test omniauth" do
    before do
      @auth = Hash.new
      @auth["provider"] = "twitter"
      @auth["uid"] = "1a3"
      @auth["info"] = Hash.new
      @auth["info"]["nickname"] = "oAuthUser"

      @user = User.create_with_omniauth(@auth)
    end

    it "User should be successfully created" do
      @user.should be_valid
    end

    it "User should have random password" do

      @user.password.should be_present
    end

  end

end