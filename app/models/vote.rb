# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_id   :integer          not null
#  votable_type :string           not null
#  value        :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  validates :votable_id, :votable_type, :value, presence: true
  validates :value, inclusion: { in: [-1, 1] }

  belongs_to :votable, polymorphic: true
end
