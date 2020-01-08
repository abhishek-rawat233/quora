//<a id="status_changing_link" style="" data-remote="true" rel="nofollow" data-method="patch" href="/users/43/mark_all_as_seen">mark all as seen</a>
class Comment {
  constructor(options) {
    this.commentsLink = $(options.commentClass);
    this.commentForm = $(options.commentFormId);
    this.commentType = this.commentForm.find(options.commentType);
    this.commentId = this.commentForm.find(options.commentId);
  }

  setForm = (e) => {
    this.targetLink = $(e.currentTarget);
    var commentableType = this.targetLink.data('commentableType');
    var commentableId = this.targetLink.data('commentableId');
    this.commentType.attr('value', commentableType);
    this.commentId.attr('value', commentableId);
    this.targetLinkDiv = $('#' +  commentableType + commentableId);
    this.targetLinkDiv.append(this.commentForm);
    this.commentForm.show();
  }


  addCommentHandler = () => {
    this.commentsLink.on('click', this.setForm);
  }

  init = () => {
    this.addCommentHandler();
  }
}

var options = {
  commentClass: '.comments',
  commentFormId: '#comment-form',
  commentType: '#commentable-type',
  commentId: '#commentable-id'
};

$(document).ready(()=>{
  var comment = new Comment(options);
  comment.init();
});
