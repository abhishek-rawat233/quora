module VoteConcern
  def update_netvotes
    update(netvotes: votes.upvote.count - votes.downvote.count)
  end
end
