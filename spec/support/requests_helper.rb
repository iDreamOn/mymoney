module RequestsHelper
  def login(user)
    login_user(user)
  end

  def login_user(user = nil)
    user ||= FactoryGirl.create(:user)
    user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    post_via_redirect user_session_path, 'user[username]' => user.username, 'user[password]' => user.password
  end

  def current_user
    subject.current_user
  end

  def json
    JSON.parse(response.body)
  end
end
