class PollsController < ApplicationController
  unloadable

  before_filter :find_project, :authorize

  def index
    @votes = @project.voting_votes
  end

  def new
    @vote = @project.voting_votes.new
    if request.post? && @vote.update(vote_params)
      redirect_to action: 'index'
    end
  end

  def delete
    @vote = @project.voting_votes.find(params[:id])
    @vote.destroy
    redirect_to action: 'index'
  end

  def edit
    @vote = @project.voting_votes.find(params[:id])
    if request.post? && @vote.update(vote_params)
      redirect_to action: 'index'
    end
  end

  def new_choice
    @vote = @project.voting_votes.find(params[:vote_id])
    @choice = @vote.voting_choices.new(choice_params)
    if request.post? && @choice.save
      redirect_to action: 'index'
    end
  end

  def remove_choice
    @choice = VotingChoice.find(params[:id])
    @choice.destroy
    redirect_to action: 'index'
  end

  def edit_choice
    @choice = VotingChoice.find(params[:id])
    @vote = @choice.vote
    if request.post? && @choice.update(choice_params)
      redirect_to action: 'index'
    end
  end

  def vote
    choice = VotingChoice.find(params[:choice_id])
    existing_vote = VotingVote.find_by(user_id: User.current.id, vote_id: choice.vote.id)

    if existing_vote.nil? || choice.vote.revote
      existing_vote&.destroy
      VotingVote.create(user_id: User.current.id, vote_id: choice.vote.id, choice_id: choice.id)
    end

    redirect_to CGI.unescape(params[:back_url].to_s)
  end

  def reset_vote
    vote = VotingPoll.find(params[:vote_id])
    if vote.revote
      vote = VotingVote.find_by(user_id: User.current.id, vote_id: vote.id)
      vote&.destroy
    end

    redirect_to CGI.unescape(params[:back_url].to_s)
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def vote_params
    params.require(:vote).permit(:name, :description, :other_attributes)
  end

  def choice_params
    params.require(:choice).permit(:name, :description, :other_attributes)
  end
end
