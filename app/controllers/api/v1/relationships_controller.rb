module Api
	module V1
		class RelationshipsController < ApplicationController
			def index
				relationships = Relationship.order(created_at: :desc)
				render json:{
					status: 'SUCCESS',
					message: 'Loaded relationships',
					data: relationships
				},
				status: :ok
			end

			def show
				relationship = Relationship.find(params[:id])
				render json:{
					status: 'SUCCESS',
					message: 'Loaded relationship',
					data: relationship
				},
				status: :ok
			end

			def create
				relationship = Relationship.new(relationship_params)

				if relationship.save
					render json:{
						status: 'SUCCESS',
						message: 'Saved relationship',
						data: relationship
					},
					status: :ok
				else
					render json:{
						status: 'ERROR',
						message: 'User not saved',
						data: relationship.errors
					},
					status: :unprocessable_entity
				end
			end

			def update
				relationship = Relationship.find(params[:id])
				if relationship.update_attributes(relationship_params)
					render json:{
						status: 'SUCCESS',
						message: 'Updated relationship',
						data: relationship
					},
					status: :ok
				else
					render json:{
						status: 'ERROR',
						message: 'Relationship not updated',
						data: relationship.errors
					},
					status: :unprocessable_entity
				end
			end

			def destroy
				relationship = Relationship.find(params[:id])
				relationship.destroy
				render json:{
					status: 'SUCCESS',
					message: 'Deleted relationship',
					data: relationship
				},
				status: :ok
			end

			def subscribe
				raw_json = JSON.parse(request.raw_post)
				key = []
				email = []
				raw_json.each do |k,v|
					key = key.push(k)
					email = email.push(v)
				end

				requestor = User.find_by(email: email.first)
				puts requestor.id
				target = User.find_by(email: email.last)
				puts target.id
				relationship = Relationship.new(following_id: target.id, follower_id: requestor.id)

				if relationship.save
					render json:{
						success: true,
						message: 'User subscribed',
						data: relationship
					},
					status: :ok
				else
					render json:{
						success: false,
						message: 'User not subscribed',
						data: relationship.errors
					},
					status: :unprocessable_entity
				end
			end

			def block
				raw_json = JSON.parse(request.raw_post)
				key = []
				email = []
				raw_json.each do |k,v|
					key = key.push(k)
					email = email.push(v)
				end

				requestor = User.find_by(email: email.first)
				target = User.find_by(email: email.last)
				relationship = Relationship.new(following_id: target.id, follower_id: requestor.id)

				if relationship.present?
					relationship.destroy
					render json:{
						success: true,
						message: 'User unsubscribed',
						data: relationship
					},
					status: :ok
				else
					blocked_friend = Friendship.create(requestor_id: requestor, receiver_id: target, status: 3)
					render json:{
						success: true,
						message: 'User blocked',
						data: blocked_friend
					},
					status: :ok
				end
			end

			private

			def relationship_params
				params.require(:relationship).permit(:following_id, :follower_id)
			end
		end
	end
end