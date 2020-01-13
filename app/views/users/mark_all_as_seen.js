class Notification {
  constructor(options) {
    this.notificationContainerId = $(options.notificationContainerId);
    this.notificationCounterId = $(options.notificationCounterId);
    this.noNotificationText = options.noNotificationText;
    this.statusChangingLink = $(options.statusChangingLink);
  }

  init = () => {
    this.notificationContainerId.text(this.noNotificationText);
    this.notificationCounterId.text('');
    this.statusChangingLink.hide();
  }
}

let options = {
  notificationContainerId: '#notifications-container',
  notificationCounterId: '#notifications-counter',
  noNotificationText: 'No New Notification',
  statusChangingLink: '#status_changing_link'
}

$(document).ready(function(){
  var notification = new Notification(options);
  notification.init();
});
