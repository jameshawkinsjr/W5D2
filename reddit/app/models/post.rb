class Post < ApplicationRecord
    validates :title, :sub_id, :user_id, presence: true

    belongs_to :author, foreign_key: :user_id, class_name: :User
    belongs_to :sub
    
    has_many :comments

    has_many :cross_posts, class_name: :PostSub, dependent: :destroy, inverse_of: :post
    has_many :subs, through: :cross_posts, source: :sub

    has_many :votes, as: :voteable

    def comments_by_parent_id
        comments = Hash.new{ [] }
        self.comments.each do |comment|
            comments[comment.parent_id] += [comment]
        end
        comments
    end
end
