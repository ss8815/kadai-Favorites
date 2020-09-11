module SessionsHelper
  #現在ログインしているユーザを取得するメソッド
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #ユーザがログインしていればtrue,ログインしていなければfalse
  def logged_in?
    !!current_user
  end
end