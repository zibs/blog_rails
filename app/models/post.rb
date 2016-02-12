class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

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

    private

      def format_case
          self.title = self.title.titleize
          self.body = self.body.humanize
      end
end
