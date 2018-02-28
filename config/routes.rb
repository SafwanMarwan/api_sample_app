Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
  	namespace 'v1' do
  		resources :users
  		resources :relationships do
  			collection do
  				post 'subscribe', to: 'relationships#subscribe'
  				post 'unsubscribe', to: 'relationships#unsubscribe'
  				post 'block', to: 'relationships#block'
  			end
  		end
  		resources :friendships do
  			collection do
  				post 'list', to: 'friendships#list_by_email'
  				post 'common_friend', to: 'friendships#common_friend_list'
  			end
  		end
  	end
  end
end

# get '/friendship/list', to: 'friendships#list_by_email', as: 'friendship_list'
# post '/friendship/list', to: 'friendships#list_by_email', as: 'friendship_list'