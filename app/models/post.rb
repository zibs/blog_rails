class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  mount_uploaders :images, ImagesUploader

  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  validates :title, presence: true, uniqueness: true, length: { minimum: 7}
  validates :body, presence: true

  before_create :format_case

  scope :recent, -> (number = 5){ order("created_at DESC").limit(number)}
  scope :search_blog, -> (term = ""){ where(["title ILIKE ? OR body ILIKE ?", "%#{term}", "%#{term}%" ]).order("updated_at DESC")}

  def body_snippet
    if self.body.length >= 100
      snippet = "#{self.body[1..100]} ... "
    else
      self.body
    end
  end

  def user_full_name
    user.full_name if user
  end

  def favourite_for(user)
    favourites.find_by(user_id: user)
  end


    private

      def format_case
          self.title = self.title.titleize
          self.body = self.body.humanize
      end
end
