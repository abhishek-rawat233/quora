//add notification class
import consumer from "./consumer"
import {AddNotification} from "./add_notification.js"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    var options = {
      title: data.content.title,
      url_slug: data.content.url_slug,
      notificationContainerId: "#notifications-container",
      notificationCounterId: "#notifications-counter",
      notificationClass: 'dropdown-item',
      notificationHandlerId: '#status_changing_link'
    }

    $(document).ready((new AddNotification(options)).init());
    //
    // let notication_counter = $('#notifications');
    // let notification = $('#navbarDropdownMenuLink-555')
    // let question_url = $('<a>', {text: data.content.title, href: '/questions/' + data.content.title.replace(/\s/, '-')})
    // let notification_item = $('<li>', {html: question_url })
    // question_url.append(notification_item)
    // let notification_count = parseInt(notification_counter.text())
    // if (isNaN(notification_count))
    //   notification_counter.text(1);
    // else
    //   notification_counter.text(notification_count + 1)
    // notification_counter.text()
  }
});
