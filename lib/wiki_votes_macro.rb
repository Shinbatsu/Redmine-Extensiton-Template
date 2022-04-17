require 'redmine'

module VoteWikiMacro
  Redmine::WikiFormatting::Macros.register do
    desc "Votes"
    macro :vote do |obj, args|
      id = args[0]

      return '' unless User.current.allowed_to?(:vote_votes, @project )

      begin
        vote = VotingVotes.find(id.to_i)
      rescue ActiveRecord::RecordNotFound
        return Redmine::WikiFormatting.to_html(Setting.text_formatting, "*[Not found vote with  id '" << id << "']*")
      end
      vote = VotingVote.find_by_user_id_and_vote_id(User.current.id, vote.id)
      render :file => '/votes/macro/vote', :locals => { :vote => vote, :vote =>vote}
    end
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Votes result"
    macro :vote_result do |obj, args|
      id = args[0]

      return '' unless User.current.allowed_to?( :vote_votes, @project )

      begin
        vote = VotingVote.find(id.to_i)
      rescue ActiveRecord::RecordNotFound
        return Redmine::WikiFormatting.to_html(Setting.text_formatting, "*[Not found vote with  id '" << id << "']*")
      end
      render :file => '/votes/macro/vote_result', :locals => { :vote => vote}

    end
  end
end