# == Schema Information
#
# Table name: statuses
#
#  id           :integer          not null, primary key
#  content      :text
#  retweeted_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Status do
  pending "add some examples to (or delete) #{__FILE__}"
end
