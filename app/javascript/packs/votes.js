class Votes {
  constructor (options) {
    this.upvotes = $(upvote);
    this.downvotes = $(downvote);
    this.netvotes = $(netvote);
  }

  incrementVotes = () => {
    this.netvotesCount += 1;
    this.netvotesElement.text(netvotesCount);
  }

  decrementVotes = () => {
    this.netvotesCount -= 1;
    this.netvotesElement.text(netvotesCount);

  }

  upvotesHandler = (e) => {
    this.upvoteElement = $(e.currentTarget);
    this.downvoteElement = $(this.upvoteElement.data('downvoteId'));
    this.netvotesElement = $(this.upvoteElement.data('newvoteId'));
    this.netvotesCount = parseInt(this.netvotesElement.text());
    var isUpvoteClicked = this.upvoteElement.data('clicked');
    if (isUpvoteClicked) {
      this.decrementVotes();
      this.upvoteElement.removeClass('clicked');
    } else {
      this.incrementVotes();
      this.upvoteElement.addClass('clicked');
      this.downvoteElement.removeClass('clicked');
    }
    this.upvoteElement.data('clicked', !isUpvoteClicked);
  }

  downvotesHandler = (e) => {
    this.downvoteElement = $(e.currentTarget);
    this.upvoteElement = $(this.downvoteElement.data('upvoteId'));
    this.netvotesElement = $(this.downvoteElement.data('netvoteId'));
    var isDownvoteClicked = this.downvoteElement.data('clicked');
    if (isDownvoteClicked) {
      this.incrementVotes();
      this.downvoteElement.removeClass('clicked');
    } else {
      this.decrementVotes();
      this.downvoteElement.addClass('clicked');
      this.upvoteElement.removeClass('clicked');
    }
    this.downvoteElement.data('clicked', !isDownvoteClicked);
  }


  addEventToUpvotes = () => {
    this.upvotes.on('click', this.upvotesHandler);
  }

  addEventToDownvotes = () => {
    this.downvotes.on('click', this.downvotesHandler);
  }

  init = () => {
    this.addEventToUpvotes();
    this.addEventToDownvotes();
  }
}

var options = {
  upvoteClass: '.upvote',
  downvote: '.downvote',
  netvote: '.netvote'
}

$(document).ready(() => {
  votes = new Votes(options);
  votes.init();
});
