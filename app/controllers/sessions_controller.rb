class SessionsController < ApplicationController
  def new
  end

  def create
    #フォームデータのemailを小文字化して取得
    email = params[:session][:email].downcase
    #フォームデータのpasswordを取得
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    #入力フォームのemailと同じメールアドレスのユーザを検索し@userへ代入
    @user = User.find_by(email: email)
    #if @userによって@userが存在するかを確認
    #パスワード確認。組み合わせが間違っていた場合にはログイン不可
    if @user && @user.authenticate(password)
      #ブラウザ=Cookieとして、サーバ=Sessionとしてログイン状態が維持
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end