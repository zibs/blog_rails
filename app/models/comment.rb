class Comment < ActiveRecord::Base
  validates :body, presence: true, uniqueness: true, length: { minimum: 2 }
end
