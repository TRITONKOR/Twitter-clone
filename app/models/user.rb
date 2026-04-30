class User < ApplicationRecord
    has_secure_password

    has_many :posts, dependent: :destroy

    validates :username, presence: true, uniqueness: true

    has_many :active_relationships,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy

    has_many :passive_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

    has_many :following,
           through: :active_relationships,
           source: :followed

    has_many :followers,
           through: :passive_relationships,
           source: :follower

    def following?(user)
        following.include?(user)
    end
end
