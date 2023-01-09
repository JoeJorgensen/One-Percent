class Post < ApplicationRecord
  belongs_to :user

  has_many :catagories, through: :post_catagories
  has_many :comments, through: :users
  has_many :likes, through: :users
  has_many :reposts, through: :users

end
