module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def score
    return 0 if votes.empty?
    votes.select('SUM(votes.value) AS my_score').first['my_score']
  end
end
