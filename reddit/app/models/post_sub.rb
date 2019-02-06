class PostSub < ApplicationRecord
    validates :post_id, uniqueness: {scope: :sub_id}
    validates :sub, :post, presence: true

    belongs_to :sub
    belongs_to :post

end

