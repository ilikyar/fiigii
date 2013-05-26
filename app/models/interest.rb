# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Interest < ActiveRecord::Base
  attr_accessible :topic_id, :user_id

  belongs_to :user
  belongs_to :topic
end
