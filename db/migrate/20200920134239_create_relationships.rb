class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # t.referencesは別のテーブルを参照させるという意味
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users } # usersテーブル参照
      # { to_table: :users }が無いとfollowテーブルを参照しエラーになる
      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
      # user_idとfollow_idのペアで重複するものが保存されないようにする
    end
  end
end
