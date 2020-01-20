class Notification {
  constructor(options) {
    this.notificationContainerId = $(options.notificationContainerId);
    this.notificationCounterId = $(options.notificationCounterId);
    this.noNotificationText = options.noNotificationText;
    this.statusChangingLink = $(options.statusChangingLink);
    this.ajaxOptions = options.ajaxOptions;
  }

  linkSetup = (e) => {
    $.ajax({
      url: this.ajaxOptions.url,
      type: this.ajaxOptions.method,
      dataType: this.ajaxOptions.dataType,
      success: () => {
        this.notificationContainerId.text(this.noNotificationText);
        this.notificationCounterId.text('');
        this.statusChangingLink.hide();
      }
    });
  }

  addHandler = () => {
    this.statusChangingLink.on('click', this.linkSetup)
  }

  init = () => {
    this.addHandler();
  }
}

let options = {
  notificationContainerId: '#notifications-container',
  notificationCounterId: '#notifications-counter',
  noNotificationText: 'No New Notification',
  statusChangingLink: '#status_changing_link',
  ajaxOptions: {
    ajaxUrlDataAttr: 'markAllNotificationPath',
    method: 'GET'
  }
}

$(document).ready(function(){
  var notification = new Notification(options);
  notification.init();
});
