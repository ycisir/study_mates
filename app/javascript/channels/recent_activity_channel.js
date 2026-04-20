import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {

  const recentActivity = document.getElementById("recent-activity");

  consumer.subscriptions.create("RecentActivityChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const container = document.getElementById("recent-activity");

      if (!container) return;

      const temp = document.createElement("div");
      temp.innerHTML = data.html;

      const newElement = temp.firstElementChild;

      // prevent duplicate insert
      if (!document.getElementById(newElement.id)) {
        container.prepend(newElement);
      }

      const LIMIT = 9;
      while (container.children.length > LIMIT) {
        container.removeChild(container.lastElementChild);
      }
    }
  });

});
