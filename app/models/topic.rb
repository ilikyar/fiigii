# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  tag        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :tag

  has_many :interests
  has_many :users, through: :interests
  has_and_belongs_to_many :statuses

  before_save { tag.downcase! }

  validates :tag, presence: true
end
