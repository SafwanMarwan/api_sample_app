module Api
	module V1
		class UsersController < ApplicationController
			def index
				users = User.order(created_at: :desc)
				render json:{
					status: 'SUCCESS',
					message: 'Loaded users',
					data: users
				},
				status: :ok
			end

			def show
				user = User.find(params[:id])
				render json:{
					status: 'SUCCESS',
					message: 'Loaded user',
					data: user
				},
				status: :ok
			end

			def create
				user = User.new(user_params)

				if user.save
					render json:{
						status: 'SUCCESS',
						message: 'Saved user',
						data: user
					},
					status: :ok
				else
					render json:{
						status: 'ERROR',
						message: 'User not saved',
						data: user.errors
					},
					status: :unprocessable_entity
				end
			end

			def update
				user = User.find(params[:id])
				if user.update_attributes(user_params)
					render json:{
						status: 'SUCCESS',
						message: 'Updated user',
						data: user
					},
					status: :ok
				else
					render json:{
						status: 'ERROR',
						message: 'User not updated',
						data: user.errors
					},
					status: :unprocessable_entity
				end
			end

			def destroy
				user = User.find(params[:id])
				user.destroy
				render json:{
					status: 'SUCCESS',
					message: 'Deleted user',
					data: user
				},
				status: :ok
			end

			def receive_update
				raw_json = JSON.parse(request.raw_post)
				sender = raw_json.first.last
				post = ""
				raw_json.each do |k,v|
					post = v
				end

				#check mentions
		  	words = post.split(' ')
		  	regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
		  	email_index = []
		  	user_list_id = []
		  	words.each_with_index do |w,i|
		  		if w.match(regex).present?
		  			email_index = email_index.push(i)
		  		end
		  	end
		  	email_index.each do |i|
		  		user = User.find_by(email: words[i])
		  		user_list_id = user_list_id.push(user.id)
		  	end

				user = User.find_by(email: sender)
				friend_list_id = user.friend_list
				follower_id = user.followers
				mention_id = user_list_id
				receiver_id = (friend_list_id + follower_id + mention_id).uniq
				receiver = User.find_by(id: receiver_id)

				render json:{
					success: true,
					message: 'Update received',
					recipients: receiver
				},
				status: :ok
			end

			private

			def user_params
				params.require(:user).permit(:first_name, :last_name, :email)
			end
		end
	end
end