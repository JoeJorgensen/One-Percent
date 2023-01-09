class Category < ApplicationRecord

    has_many :posts, through: :post_catagories
end
