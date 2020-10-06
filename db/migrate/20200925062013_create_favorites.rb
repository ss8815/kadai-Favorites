class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true # user_idカラムとして存在
      t.references :micropost, foreign_key: true # micropost_idカラムとして存在

      t.timestamps
      
      t.index [:user_id, :micropost_id], unique: true
    end
  end
end
