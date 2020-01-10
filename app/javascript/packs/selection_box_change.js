class SelectionBoxChange {
  constructor(options) {
    this.selectionBoxes = $(options.selectionBoxClass);
  }

  selectMultiple = (e) => {
    e.preventDefault;
    this.target = $(e.currentTarget);
    this.target.attr('selected', !this.target.prop('selected'));
    return false;
  }

  addHandler = () => {
    this.selectionBoxes.children('option').on('mousedown', this.selectMultiple);
  }

  init = () => {
    this.addHandler();
  }
}


$(document).ready( () => {
  var options = {
    selectionBoxClass: '.selection-box'
  };
  var selectionBox = new SelectionBoxChange(options);
  selectionBox.init();
});
