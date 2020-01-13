class Votes {
  constructor (options) {
    this.upvotes = $(options.upvote);
    this.downvotes = $(options.downvote);
    this.ajaxOptions = options.ajaxOptions;
  }

  upvotesHandler = (e) => {
    e.preventDefault();
    this.upvoteElement = $(e.currentTarget);
    this.downvoteElement = $(this.upvoteElement.data('downvoteId'));
    this.netvotesElement = $(this.upvoteElement.data('netvoteId'));
    this.voteableId = this.upvoteElement.data('voteableId');
    this.voteableType  = this.upvoteElement.data('voteableType');
    this.voteType = this.upvoteElement.val();
    this.baseUserId = this.upvoteElement.data('baseUserId');
    var isUpvoteClicked = this.upvoteElement.data('clicked');
    if (isUpvoteClicked) {
      this.upvoteElement.removeClass('clicked');
    } else {
      this.upvoteElement.addClass('clicked');
      this.downvoteElement.removeClass('clicked');
    }
    this.upvoteElement.data('clicked', !isUpvoteClicked);
    this.updateNetVotes();
  }

  downvotesHandler = (e) => {
    e.preventDefault();
    this.downvoteElement = $(e.currentTarget);
    this.upvoteElement = $(this.downvoteElement.data('upvoteId'));
    this.netvotesElement = $(this.downvoteElement.data('netvoteId'));
    this.voteableId = this.downvoteElement.data('voteableId');
    this.voteableType  = this.downvoteElement.data('voteableType');
    this.voteType = this.downvoteElement.val();
    this.baseUserId = this.downvoteElement.data('baseUserId');
    var isDownvoteClicked = this.downvoteElement.data('clicked');
    if (isDownvoteClicked) {
      this.downvoteElement.removeClass('clicked');
    } else {
      this.downvoteElement.addClass('clicked');
      this.upvoteElement.removeClass('clicked');
    }
    this.downvoteElement.data('clicked', !isDownvoteClicked);
    this.updateNetVotes();
  }

  updateNetVotes = () => {
    var netvotesElement = this.netvotesElement
    $.ajax({
      url: this.ajaxOptions.url,
      type: this.ajaxOptions.method,
      data: {"voteable_id" : this.voteableId,
             "voteable_type" : this.voteableType,
             "vote_type" : this.voteType,
             "base_user_id": this.baseUserId
           },
      dataType: this.ajaxOptions.dataType,
      success: function(data) {
        netvotesElement.html(data["netvotes"])
      },
      failure: function(data) {
        netvotesElement.html('not working please refresh')
      }
    });
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
    downvote: '.downvote',
    ajaxOptions: {
      url: '/update_votes',
      method: 'GET',
      dataType: 'json'
    }
  };

  votes = new Votes(options);
  votes.init();
});
