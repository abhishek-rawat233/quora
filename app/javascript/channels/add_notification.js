export class AddNotification {
  constructor (options) {
    this.notificationTitle = options.title;
    this.notificationSource = '/questions/' + options.url_slug;
    this.notificationClass = options.notificationClass;
    this.notificationContainer = $(options.notificationContainerId);
    this.notificationCounter = $(options.notificationCounterId);
    this.notificationHandlerLink = $(options.notificationHandlerId);
  }

  notificationCreator = () => {
    this.notification = $('<a>', {
      text: this.notificationTitle,
      href: this.notificationSource,
      class: this.notificationClass
    });
  }

  appendNotification = () => {
    this.notificationContainer
  }

  showNotificationHandlerLink = () => {
    this.notificationHandlerLink.show();
  }

  increaseNotificationCounter = () => {
    var count = parseInt(this.notificationCounter.text());
    if (isNaN(count)) {
      this.notificationContainer.text("")
      this.notificationCounter.html(1);
    } else {
      this.notificationCounter.html( count + 1 );
    }
  }

  init = () => {
    this.notificationCreator();
    this.increaseNotificationCounter();
    this.appendNotification();
    this.showNotificationHandlerLink();
  }
}
