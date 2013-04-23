class Comment < ActiveRecord::Base
  attr_accessible :content, :reply_comment_id, :status_id, :user_id
  belongs_to :user
  belongs_to :status
  has_many :replyings, class_name: "Comment", foreign_key: "reply_comment_id", dependent: :destroy
  belongs_to :reply_comment, class_name: "Comment"

  validates :content, presence: true
  validates :status_id, presence: true

  def as_json(options={})
  	reply = options[:without_reply] ? nil : self.reply_comment
  	{
  		id: self.id,
  		content: self.content,
  		created_at: self.created_at,
  		user: self.user.as_json(user: options[:user]),
  		status: self.status.to_json(user: options[:user]),
  		reply_comment: reply.as_json(:without_reply => true, user: options[:user]),
  	}
  end

end
