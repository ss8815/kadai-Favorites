module UsersHelper
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    #gravatar_idはuser.emailをdowncase(全て小文字に変換)したものを更に暗号化した文字列
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end