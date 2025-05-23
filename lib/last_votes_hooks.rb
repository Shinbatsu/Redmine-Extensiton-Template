class LastVotesHooks < Redmine::Hook::ViewListener

  def view_welcome_index_right(context = { })
    if !User.current.projects.any? || !User.current.logged?
      return ''
    end

    block = HomeBlock.find_by_name('votes')
    context[:controller].send(:render_to_string, {:locals => {:votes => VotingVote.unvoted_for_all()}.merge(context), :file => "/votes/votes_box"}) if block
  end

  def view_projects_show_right(context = { })
    if !User.current.logged?
      return ''
    end

    project = context[:project]
    block = OverviewBlock.find_by_project_id_and_name(project,'votes')
    context[:controller].send(:render_to_string, {:locals => {:votes => VotingVote.unvoted(context[:project].id)}.merge(context), :file => "/votes/votes_box"}) if block
  end

end
