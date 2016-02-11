class Comment < ActiveRecord::Base
  belongs_to :post
  validates :body, presence: true,
            uniqueness: { scope: :post_id },
            length: { minimum: 2 }


end
