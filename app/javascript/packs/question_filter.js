class QuestionFilter {
  constructor(options) {
    this.questionFilter = $(options.filter);
    this.allQuestions = $(options.containerClass);
    this.userRelatedQuestion = this.allQuestions.filter(options.userRelatedQuestion);
    this.followingPostedQuestion = this.allQuestions.filter(options.followingPostedQuestion);
  }

  loadQuestions = (e) => {
    this.target = $(e.currentTarget);
    switch (this.target.val()) {
      case 'related questions': this.allQuestions.hide();
                                this.userRelatedQuestion.show();
                                break;
      case 'All questions': this.allQuestions.show();
                            break;
      case 'posted by followings': this.allQuestions.hide();
                                   this.followingPostedQuestion.show();
                                   break;
      default: this.allQuestions.show();
    }
  }

  addHandler = () => {
    this.questionFilter.on('change', this.loadQuestions);
  }

  init = () => {
    this.addHandler();
    this.questionFilter.change();
  }
}

$(document).ready(()=>{
  var options= {
    filter: 'select[data-class="question-filter"]',
    containerClass: 'div[data-class="question-container"]',
    userRelatedQuestion: '[data-user-related-question="true"]',
    followingPostedQuestion: '[data-user-following-posted-question="true"]'
  };

  var questionFilter = new QuestionFilter(options);
  questionFilter.init();
});
