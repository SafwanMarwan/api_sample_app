class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :body, :user_id

  # def check_mention(text)
  # 	words = text.split(' ')
  # 	regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # 	email_index = []
  # 	user_list_id = []
  # 	words.each_with_index do |w,i|
  # 		if w.match(regex).present?
  # 			email_index = email_index.push(i)
  # 		end
  # 	end

  # 	email_index.each do |i|
  # 		user = User.find_by(email: words[i])
  # 		user_list_id = user_list_id.push(user.id)
  # 	end
  # 	return user_list_id
  # end
end
