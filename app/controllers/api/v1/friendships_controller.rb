require 'json'

module Api
	module V1
		class FriendshipsController < ApplicationController
			def index
				friendships = Friendship.order(created_at: :desc)
				render json:{
					status: 'SUCCESS',
					message: 'Loaded friendships',
					data: friendships
				},
				status: :ok
			end

			def show
				friendship = Friendship.find(params[:id])
				render json:{
					status: 'SUCCESS',
					message: 'Loaded friendship',
					data: friendship
				},
				status: :ok
			end

			def create
				raw_json = JSON.parse(request.raw_post)
				key = ""
				email = ""
				raw_json.each do |k,v|
					key = k
					email = v
				end

				users_id = User.where(email: email).pluck(:id)
				check_blocked = Friendship.where(requestor_id: users_id.first, receiver_id: users_id.last, status: 3) || Friendship.where(requestor_id: users_id.last, receiver_id: users_id.first, status: 3)

				if check_blocked.present?
					render json:{
							success: false,
							message: 'Friendship is blocked',
							data: check_blocked
						},
						status: :unprocessable_entity
				else
					friendship = Friendship.new(requestor_id: users_id.first, receiver_id: users_id.last, status: 1)

					if friendship.save
						render json:{
							success: true,
							message: 'Saved friendship',
							data: friendship
						},
						status: :ok
					else
						render json:{
							success: false,
							message: 'Friendship not saved',
							data: friendship.errors
						},
						status: :unprocessable_entity
					end
				end
			end

			def list_by_email
				raw_json = JSON.parse(request.raw_post)
				key = ""
				email = ""
				raw_json.each do |k,v|
					key = k
					email = v
				end

				friend_list = User.find_by(email: email).friend_list
				render json:{
					success: true,
					message: 'Loaded friendlist',
					friends: friend_list,
					count: friend_list.count
				},
				status: :ok
			end

			def common_friend_list
				raw_json = JSON.parse(request.raw_post)
				key = ""
				email = ""
				raw_json.each do |k,v|
					key = k
					email = v
				end

				first_list = User.find_by(email: email.first).friend_list.pluck(:id)
				second_list = User.find_by(email: email.last).friend_list.pluck(:id)
				common_list = first_list + second_list
				common_list_id = common_list.select{ |a| common_list.count(a) > 1 }.uniq
				friend_list = User.find(common_list_id)

				render json:{
					success: true,
					message: 'Loaded common friend list',
					friends: friend_list,
					count: friend_list.count
				},
				status: :ok
			end

			def update
				friendship = Friendship.find(params[:id])
				if friendship.update_attributes(friendship_params)
					render json:{
						status: 'SUCCESS',
						message: 'Updated friendship',
						data: friendship
					},
					status: :ok
				else
					render json:{
						status: 'ERROR',
						message: 'Friendship not updated',
						data: friendship.errors
					},
					status: :unprocessable_entity
				end
			end

			def destroy
				friendship = Friendship.find(params[:id])
				friendship.destroy
				render json:{
					status: 'SUCCESS',
					message: 'Deleted friendship',
					data: friendship
				},
				status: :ok
			end

			def add_friend_by_email
				
			end

			private

			def friendship_params
				params.require(:friendship).permit(:requestor_id, :receiver_id)
			end

			def friends_params
				params.require(:friends)
			end
		end
	end
end