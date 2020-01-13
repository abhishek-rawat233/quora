//add notification class
import consumer from "./consumer"
import {AddNotification} from "./add_notification.js"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    var options = {
      title: data.content.title,
      url_slug: data.content.url_slug,
      notificationContainerId: "#notifications-container",
      notificationCounterId: "#notifications-counter",
      notificationClass: 'dropdown-item',
      notificationHandlerId: '#status_changing_link'
    }

    $(document).ready((new AddNotification(options)).init());
  }
});
