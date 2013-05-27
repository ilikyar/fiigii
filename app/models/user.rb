# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  descript        :text
#  url             :string(255)
#  gender          :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  refresh_at      :datetime         default(2013-04-19 02:16:01 UTC)
#

class User < ActiveRecord::Base
  attr_accessible :admin, :descript, :email, :gender, :name, :password,:password_confirmation, :url, :refresh_at
  has_secure_password
  has_many :statuses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_and_belongs_to_many :favourites, 
                          class_name: "Status", 
                          foreign_key: "liker_id",
                          association_foreign_key: "status_id",
                          join_table: "joinforliker"

  has_many :interests
  has_many :topics, through: :interests

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :gender, inclusion: { :in => ["m", "f", ""], :message => "Must be m or f"}

  #default_scope order: 'users.refresh_at DESC'

  def reset
    self.update_attribute(:refresh_at, 1.weeks.ago)
  end

  def friends_timeline
    result = Status.from_users_followed_by(self)
    # self.update_attribute(:refresh_at, Time.now)
    result
  end

  def timeline
    self.statuses.limit(100)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def as_json(options={})
    if options[:user]
      is_following = options[:user].following?(self) ? true : false
      is_followed = self.following?(options[:user]) ? true : false
    else
      is_following = false
      is_followed = false
    end
    
    {
      id: self.id,
      name: self.name,
      description: self.descript,
      url: self.url,
      gender: self.gender,
      followers_count: self.followers.count,
      followeing_count: self.followed_users.count,
      statuses_count: self.statuses.count,
      favourites_count: self.favourites.count,
      created_at: self.created_at,
      following: is_following,
      follow_me: is_followed
    }
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
