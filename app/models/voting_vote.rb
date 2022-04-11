class VotingVote < ActiveRecord::Base
   belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
   belongs_to :vote, :class_name => 'VotingPoll', :foreign_key => 'vote_id'
   belongs_to :choice, :class_name => 'VotingChoice', :foreign_key => 'choice_id'  
end                                                                   