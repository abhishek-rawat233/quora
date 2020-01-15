class VotesController < ApplicationController
  before_action :get_vote, only: :update

  def edit
    @vote = Vote.new
  end

  def update
    if @vote.update(vote_type: get_vote_type)
      render json: { netvotes: @vote.voteable.netvotes }
    end
  end

  def get_vote
    @vote = Vote.find_or_initialize_by(vote_params)
  end

  def get_vote_type
    if @vote.vote_type == params[:vote_type]
      'novote'
    else
      params[:vote_type]
    end
  end

  def vote_params
    params.permit(:base_user_id, :voteable_type, :voteable_id)
  end
end
