class ApplicationController < ActionController::Base
  # ControllerからHelperのメソッドを使うことはデフォルトではできない
  #logged_in?を使用するためincludeする
  include SessionsHelper
    
  private
  
  def require_user_logged_in
    #unlessはfalseのときに処理を実行
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
  end
end
