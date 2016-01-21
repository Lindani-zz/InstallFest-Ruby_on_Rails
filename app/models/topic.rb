class Topic < ActiveRecord::Base
  has_many :votes, dependent: :destroy

  def self.sorted_topics
  	# There are ways to do this with database agnostic syntax, but the resulting
    # Ruby/Rails code is rather overwhelming
    find_by_sql(
      "SELECT topics.*,
      (SELECT count(votes.topic_id) FROM votes WHERE votes.topic_id = topics.id)
        AS votes_count
      FROM topics
      ORDER BY votes_count desc"
    )
  end
end
