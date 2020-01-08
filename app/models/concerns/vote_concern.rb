module VoteConcern
  def update_netvotes
    netvotes = votes.upvote - votes.downvote
  end
end
