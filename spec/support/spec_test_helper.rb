module SpecTestHelper
  def login(user)
    login_user(user)
  end

  def login_user(user=nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = user || FactoryGirl.create(:user)
    user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in user
  end

  def current_user
    subject.current_user
  end
end
