class Vote < ApplicationRecord
    validates :value, presence: true
    validates :value, inclusion: { in: %w(1 -1)}
    validates_uniqueness_of :user_id, scope: %i[voteable_id voteable_type]
    belongs_to :voteable, polymorphic: true
end
