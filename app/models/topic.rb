class Topic < ActiveRecord::Base
  attr_accessible :tag

  has_many :interests
  has_many :users, through: :interests
  has_and_belongs_to_many :statuses

  before_save { tag.downcase! }

  validates :tag, presence: true
end