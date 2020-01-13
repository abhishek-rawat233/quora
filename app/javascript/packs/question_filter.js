class QuestionFilter() {
  constructor() {
    this.questionFilter = $(options.filterClass);
  }

  loadQuestions = (e) => {
    this.target = $(e.current_target);
    $.ajax(
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
    }
    );
  }

  addHandler = () => {
    this.questionFilter.on('change', this.loadQuestions)
  }

  init = () => {
    this.addHandler();
  }
}

$(document).ready(()=>{
  var options= {
    containerClass: 'question-container',
    voteClass: 'votes',
    questionClass: 'question',

  };
});
