class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true, length: { minimum: 7}
  validates :body, presence: true
  before_create :format_case
  scope :recent, -> (number = 5){ order("created_at DESC").limit(number)}
  scope :search_blog, -> (term = ""){ where(["title ILIKE ? OR body ILIKE ?", "%#{term}", "%#{term}%" ]).order("updated_at DESC")}

    private
      def format_case
          self.title = self.title.titleize
          self.body = self.body.humanize
      end
end
