class Status < ActiveRecord::Base
  attr_accessible :content, :retweeted_id, :user_id

  belongs_to :user
  has_and_belongs_to_many :likers, 
  						  class_name: "User", 
  						  foreign_key: "status_id",
    					  association_foreign_key: "liker_id",
    					  join_table: "joinforliker"

  has_and_belongs_to_many :haters,
  						  class_name: "User", 
  						  foreign_key: "status_id",
    					  association_foreign_key: "hater_id",
    					  join_table: "joinforheater"

  has_and_belongs_to_many :topics

  has_many :retweets, class_name: "Status", foreign_key: "retweeted_id"
  has_many :comments
  belongs_to :retweeted, class_name: "Status"

  default_scope order: 'statuses.created_at DESC'

  validates :content, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("(created_at > :refresh_at) AND (user_id IN (#{followed_user_ids}) OR user_id = :user_id)", 
          user_id: user.id, refresh_at: user.refresh_at).limit(50)
  end

  def good_count
  	likers.count
  end

  def bad_count
  	haters.count
  end

  def good!(user)
  	likers << user
  end

  def bad!(user)
  	haters << user
  end

  def as_json(options={})
  	if options[:user]
  		is_favorited = options[:user].favourites.include? self
  	end

    retweeted_status = options[:without_retweet] ? nil : self.retweeted

  	{
  		id: self.id,
  		content: self.content,
  		favourites: is_favorited,
  		topics: self.topics,
  		reposts_count: self.retweets.count,
  		comments_count: self.comments.count,
  		good_count: self.good_count,
  		bad_count: self.bad_count,
      created_at: self.created_at,
  		user: User.find_by_id(self.user.id).as_json(options),
  		retweeted_status: retweeted_status.as_json(without_retweet: true)
  	}
  end
end
