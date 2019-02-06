class Comment < ApplicationRecord
    validates :content, :user_id, :post_id, presence: true
    
    belongs_to :post
    belongs_to :user

    belongs_to :parent, class_name: :Comment, optional: true
    has_many :children, class_name: :Comment, foreign_key: :parent_id

    has_many :votes, as: :voteable
end
