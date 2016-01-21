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

  	def vote_count
	    # In the above SQL there is the line that counts the votes and creates the
	    # selected query column "votes_count", which means that each Topic has a
	    # "votes_count" attribute.
	    #
	    # If we have the attribute, use it, otherwise compute the attribute. For
	    # this to truly be effective, in the index page, replace "topic.votes.count"
	    # with "topic.vote_count"
	    attributes['votes_count'] || votes.count
	end

end
