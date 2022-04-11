class VotingPoll < ActiveRecord::Base
  belongs_to :project
  has_many :choices, class_name: 'VotingChoice', foreign_key: 'vote_id', dependent: :delete_all, -> { order('created_on') }

  validates :question, presence: true, length: { maximum: 128 }

  def vote(answer)
    increment(answer == 'yes' ? :yes : :no)
  end

  def self.unvoted_for_all
    return [] unless User.current.projects.any?

    votes = VotingPoll.joins("LEFT JOIN #{VotingVote.table_name} vv ON #{VotingPoll.table_name}.id = vv.vote_id AND vv.user_id = #{User.current.id}")
                      .where("#{VotingPoll.table_name}.project_id IN (?) AND vv.id IS NULL", User.current.projects.ids)
                      .order("#{VotingPoll.table_name}.created_on DESC")
                      .limit(5)

    votes
  end

  def self.unvoted(project_id)
    votes = VotingPoll.joins("LEFT JOIN #{VotingVote.table_name} vv ON #{VotingPoll.table_name}.id = vv.vote_id AND vv.user_id = #{User.current.id}")
                      .where("#{VotingPoll.table_name}.project_id = ? AND vv.id IS NULL", project_id)
                      .order("#{VotingPoll.table_name}.created_on DESC")
                      .limit(5)

    votes
  end
end
