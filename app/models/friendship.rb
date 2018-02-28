class Friendship < ApplicationRecord
	belongs_to :requestor, foreign_key: 'requestor_id', class_name: 'User'
	belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User'

	validates_presence_of :requestor_id, :receiver_id

	enum status: [:pending, :approved, :rejected, :blocked]
end
