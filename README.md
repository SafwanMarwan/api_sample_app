# api_sample_app

This application provide basic API for social network friend management theme.

## Ruby version

* Ruby: 2.3.3

* Rails: 5.1.5

## List of APIs

* receive_update:	POST	/api/v1/users/receive_update

* list_all_users:	GET	/api/v1/users

* create_user: POST	/api/v1/users

* list_a_user:	GET	/api/v1/users/:id

* update_a_user: PATCH	/api/v1/users/

* delete_a_user: DELETE	/api/v1/users/:id

* subscribe_a_user: POST	/api/v1/relationships/subscribe

* block_a_user:	POST	/api/v1/relationships/block

* list_all_relationships:	GET	/api/v1/relationships

* create_relationship: POST	/api/v1/relationships

* list_a_relationship	GET	/api/v1/relationships/:id

* update_a_relationship: PATCH	/api/v1/relationships/:id

* delete_a_relationship: DELETE	/api/v1/relationships/:id

* list_all_friends_using_email:	POST	/api/v1/friendships/list

* list_common_friends:	POST	/api/v1/friendships/common_friend

* list_all_friendshipapi_v1_friendships_path GET	/api/v1/friendships

* create_a_friendship POST	/api/v1/friendships

* list_a_friendship: GET	/api/v1/friendships/:id

* update_a_friendship: PATCH	/api/v1/friendships/:id

* delete_a friendship: DELETE	/api/v1/friendships/:id

## How to run

For this app, we need to have:

* a working rails environment installed.

* Postman chrome extension

First, download this app to your local machine. Then run `$ rails server`. The app can be accessed through localhost:3000. We can test the APIs with Postman app.
