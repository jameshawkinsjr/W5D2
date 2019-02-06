class Sub < ApplicationRecord
    validates :title, :description, :user_id, presence: true
    validates :title, uniqueness: true
    belongs_to :moderator, foreign_key: :user_id, class_name: :User
    has_many :posts

    has_many :cross_posts, class_name: :PostSub
    has_many :cross_posted_posts, through: :cross_posts, source: :post
    
end
