# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  author_id         :integer          not null
#  content           :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  include Votable
  validates :author_id, :post_id, :content, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :post
  belongs_to :parent_comment, class_name: "Comment"
  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
end
