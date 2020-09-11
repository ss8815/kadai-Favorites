class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy　#correct_userで取得した@micropostをdestroyしている
    flash[:success] = 'メッセージを削除しました。'
    #アクションが実行されたページへ戻る
    redirect_back(fallback_location: root_path) #このアクションが実行されたページに戻るメソッド
  end

  private

  def micropost_params
    #micropostモデルのフォームから得られるcontentカラムを選択
    params.require(:micropost).permit(:content)
  end
  #削除しようとしているMicropostが本当にログインユーザが所有しているものかを確認している
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost #unless文はnilかfalseのときに実行
      redirect_to root_url #トップページに戻される
    end
  end
end