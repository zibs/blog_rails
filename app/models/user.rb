class User < ActiveRecord::Base
  before_create :generate_api_key

  has_many :posts, dependent: :nullify
  has_many :comments, through: :posts

  has_many :favourites, dependent: :destroy
  has_many :favourite_posts, through: :favourites, source: :post

  validate :password_length
  # before_update :password_length

	attr_accessor :reset_token
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password
  validates :password, length: { minimum: 5 }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX


  def full_name
    "#{first_name} #{last_name}".titleize
  end
  def full_name_downcase
    "#{first_name} #{last_name}".downcase.split(" ").join("")
  end



  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authentic_token?(token)
    BCrypt::Password.new(self.reset_digest).is_password?(token)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

      private

      def password_length
        if password.present?
          true unless password.length <= 6
        elsif !password.present?
          true
        else
          errors.add(:password, "must be longer than 6 characters")
          # false
          # use false if doing a before_update callback
        end
      end


        # options: SecureRandom.hex,
      def generate_api_key
        self.api_key = SecureRandom.hex(32)
        while User.exists?(api_key: self.api_key)
          self.api_key = SecureRandom.hex(32)
        end
        # begin
          #     self.api_key = SecureRandom.hex(32)
          # end while User.exists?(api_key: self.api_key)
      end
      # User.where(api_key: nil).each { |u| u.send(:generate_api_key); u.save}


end
