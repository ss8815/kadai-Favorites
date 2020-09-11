class Micropost < ApplicationRecord
  #UserとMicropostの一対多を表現
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
end
