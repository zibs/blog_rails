class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :post_category
  has_many :comments
  # has_many :favourites

  def post_category
    self.object.category if self.object.category
  end


end
