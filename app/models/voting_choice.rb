class VotingChoice < ActiveRecord::Base
  belongs_to :vote, :class_name => 'VotingPoll', :foreign_key => 'vote_id'
  has_many :votes,  :class_name => 'VotingVote', :foreign_key => 'choice_id', :dependent => :delete_all,
           :order => "#{VotingVote.table_name}.created_on"
  validates_presence_of :text
  validates_length_of :text, :maximum => 80
end
