class VotesController < ApplicationController
  def update
    @vote = Vote.new
    if @vote.update(vote_params)
      p '#########################3333'
    else
      p '$$$$$$$$$$$$$$$$$$$$$$$$$$$44'
    end
  end

  def vote_params
    params(:vote_type, :base_user_id, :voteable_type, :voteable_id).permit
  end
end
