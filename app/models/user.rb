class User < ApplicationRecord
    #self.email.downcase!は文字を全て小文字に変換する
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts #一対多を表現
    
    # あくまでRelationshipモデルへの参照ということ。つまりUserから見た中間テーブルとの関係
    has_many :relationships # 自分がフォローしているUserへの参照 
    has_many :followings, through: :relationships, source: :follow
    # フォローしているUser達,:relationshipsの結果を中間テーブルとして指定,参照先のid指定
    # user.followings = userが中間テーブルを取得し,1つ1つのrelationshipのfollow_idから自分がフォローしているUser達を取得
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    # 自分をフォローしているUserへの参照,参照するクラスを指定,user_id側ではないことを明示
    has_many :followers, through: :reverses_of_relationship, source: :user
    # user.followers = userが中間テーブルを取得,reverses_of_relationshipのuser_idから自分をフォローしているUser達を取得
    # 中間テーブルを経由して相手の情報を取得するにはthroughを使用
    
    has_many :favorites, dependent: :destroy# 自分がお気に入り追加したMicropostへの参照
    has_many :likes, through: :favorites, source: :micropost
    
    def follow(other_user)
      unless self == other_user # フォローするother_userが自分自身ではないか検証
      # 実行したUserのインスタンスがself 
          self.relationships.find_or_create_by(follow_id: other_user.id)
          # 見つからなければフォロー関係を保存
      end
    end
    
    def unfollow(other_user) # フォローがあればアンフォロー
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship # relationshipが存在すればdestroy
    end
    
    def following?(other_user)
      self.followings.include?(other_user) # self.followingsでフォローしているUserを取得
      # include?(other_user)によってother_userが含まれていないか確認
    end
    
    def feed_microposts
      Micropost.where(user_id: self.following_ids + [self.id])
      # Micropost.where(user_id:フォローユーザ+自分自身)となるMicropostを全て取得
    end
    
    def favorite(micropost)
      self.favorites.find_or_create_by(micropost_id: micropost.id)
    end
    
    def unfavorite(micropost) # 追加があれば削除
      favorite = self.favorites.find_by(micropost_id: micropost.id)
      favorite.destroy if favorite # favoriteが存在すればdestroy
    end
    
    def like?(micropost)
      self.likes.include?(micropost) # self.likesでお気に入りしているMicropostを取得
      # include?(micropost)によってmicropostが含まれていないか確認
    end
end