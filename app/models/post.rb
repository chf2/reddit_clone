# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  include Votable

  validates :title, :author_id, presence: true

  belongs_to :author, class_name: "User"
  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments

  after_touch :score

  def comments_by_parent_id
    comments_hash = Hash.new { |h, k| h[k] = Array.new }
    comments.each do |comment|
      comments_hash[comment.parent_comment_id] << comment
    end
    comments_hash
  end


end
