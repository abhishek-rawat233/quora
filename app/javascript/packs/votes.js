class Votes {
  constructor (options) {
    this.upvotes = $(options.upvote);
    this.downvotes = $(options.downvote);
  }

  incrementVotes = () => {
    this.netvotesCount += 1;
    this.netvotesElement.text(this.netvotesCount);
  }

  decrementVotes = () => {
    this.netvotesCount -= 1;
    this.netvotesElement.text(this.netvotesCount);
  }

  upvotesHandler = (e) => {
    this.upvoteElement = $(e.currentTarget);
    this.downvoteElement = $(this.upvoteElement.data('downvoteId'));
    this.netvotesElement = $(this.upvoteElement.data('netvoteId'));
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
    this.netvotesCount = parseInt(this.netvotesElement.text());
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

$(document).ready(() => {
  var options = {
    upvote: '.upvote',
    downvote: '.downvote'
  };

  votes = new Votes(options);
  votes.init();
});
