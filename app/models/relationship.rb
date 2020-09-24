class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  # followがFollowクラスを参照することを防ぎ、Userクラスを参照すると明示
end