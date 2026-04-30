class Message < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :receiver, class_name: "User"

    validates :content, presence: true, length: { maximum: 280 }

    has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
    has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy
end
