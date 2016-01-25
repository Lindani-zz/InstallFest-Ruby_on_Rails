class Topic < ActiveRecord::Base
  has_many :votes, dependent: :destroy

	def self.sorted_topics
	  # Sorting topics by their number of votes
	    Topic.all.sort_by { |topic| topic.votes.count }.reverse
	end

end
