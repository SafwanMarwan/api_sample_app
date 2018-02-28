class User < ApplicationRecord
	has_many :follower_relationships, foreign_key: :following_id, class_name: 'Relationship'
	has_many :followers, through: :follower_relationships, source: :follower

	has_many :following_relationships, foreign_key: :follower_id, class_name: 'Relationship'
	has_many :following, through: :following_relationships, source: :following

	has_many :requestor_relationships, foreign_key: :receiver_id, class_name: 'Friendship'
	has_many :requestors, through: :requestor_relationships, source: :requestor

	#requesting friendship, to whom the request is received
	has_many :receiver_relationships, foreign_key: :requestor_id, class_name: 'Friendship'
	has_many :receivers, through: :receiver_relationships, source: :receiver

	has_many :posts

	validates_presence_of :first_name, :last_name, :email

	def follow(user_id)
		following_relationships.create(following_id: user_id)
	end

	def unfollow(user_id)
		following_relationships.find_by(following_id: user_id).destroy
	end

	def request_friend(user_id)
		receiver_relationships.create(receiver_id: user_id)
	end

	def approve_friendship(user_id)
		requestor_relationships.where(receiver_id: self.id, requestor_id: user_id).update(status: 1)
	end

	def reject_friendship(user_id)
		requestor_relationships.where(receiver_id: self.id, requestor_id: user_id).update(status: 2)
	end

	def block_friendship(user_id)
		friend = requestor_relationships.where(receiver_id: self.id, requestor_id: user_id) || receiver_relationships.where(receiver_id: user_id, requestor_id: self.id)
		friend.update(status: 3)
	end

	def friend_list
		received_list = requestor_relationships.where(status: 1).pluck(:requestor_id)
		requested_list = receiver_relationships.where(status: 1).pluck(:receiver_id)
		list = received_list + requested_list
		return User.find(list)
	end

	def common_friend(first_email, second_email)
		first_list = User.find_by(email: first_email).friend_list.pluck(:id)
		second_list = User.find_by(email: second_email).friend_list.pluck(:id)
		common_list = first_list + second_list
		common_list_id = common_list.select{ |a| common_list.count(a) > 1 }.uniq
		return User.find(common_list_id)
	end
end
