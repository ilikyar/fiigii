# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string(255)
#  user_id          :integer
#  status_id        :integer
#  reply_comment_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
