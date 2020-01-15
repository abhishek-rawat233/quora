class QuestionSearch {
  constructor(options){
    this.searchBox = $(options.searchBox);
    this.questions = $(options.questions);
    this.questionTitle = options.title;
    this.questionStore = $(options.questionStore);
  }

  searchQuestions = (e) => {
    var searchKey = this.searchBox.val().toLowerCase();
    var viewList = [];
    this.questions.each((key, question) => {
      if(question.dataset.title.toLowerCase().includes(searchKey)) {
        viewList.push(question);
      }
    })
    this.display(viewList);
  }

  display = (viewList) => {
    this.questionStore.html(viewList);
  };

  addHandler = () => {
    this.searchBox.on('keyup', this.searchQuestions);
  }

  init = () => {
    this.addHandler();
  }
}

$(document).ready(()=>{
  var options = {
    searchBox: 'input[data-id="question-searchbox"]',
    questions: 'div[data-class="question-container"]',
    title: 'title',
    questionStore: 'div[data-class="question-store"]'
  };

  var searchBox = new QuestionSearch(options);
  searchBox.init();
});
