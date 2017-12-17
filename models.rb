class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
end

class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments
end

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :awact
end

class Awact < ActiveRecord::Base
	belongs_to :post
end
