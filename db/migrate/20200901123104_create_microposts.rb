class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      #実際のデータベース上では,user_idカラムとして存在。foreign_keyは外部キー制約
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
