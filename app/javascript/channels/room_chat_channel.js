import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {

  const room_element = document.getElementById("room-id");
  if (!room_element) return;

  const room_id = room_element.getAttribute("data-room-id");

  const messageBody = document.getElementById("message-body");
  const filesUpload = document.getElementById("file-upload");
  const sendButton = document.getElementById("send-button");
  const uploadTrigger = document.getElementById("upload-trigger");
  const fileCount = document.getElementById("file-count");

  // Enable/disable send button
  const checkMessageAndImage = () => {
    sendButton.disabled = !(
      messageBody.value.trim() !== "" || filesUpload.files.length > 0
    );
  };

  // Update file count
  const updateFileCount = () => {
    const count = filesUpload.files.length;
    if (fileCount) {
      fileCount.textContent = count > 0 ? `${count} file(s)` : "";
    }
  };

  // trigger hidden file input
  if (uploadTrigger && filesUpload) {
    uploadTrigger.addEventListener("click", () => {
      filesUpload.click();
    });
  }

  // listeners
  messageBody.addEventListener("input", checkMessageAndImage);

  filesUpload.addEventListener("change", () => {

    const files = Array.from(filesUpload.files);

    const invalidFile = files.find(file => file.size / 1024 / 1024 > 5);

    if (invalidFile) {
      alert("Maximum file size is 5MB. Please choose a smaller file.");
      filesUpload.value = "";
      return;
    }

    updateFileCount();
    checkMessageAndImage();
  });

  checkMessageAndImage();

  consumer.subscriptions.create(
    { channel: "RoomChatChannel", room_id: room_id },
    {
      connected() {},

      disconnected() {},

      received(data) {
        const messageContainer = document.getElementById("messages");
        messageContainer.innerHTML += data.html;

        // Reset after successful send
        messageBody.value = "";
        filesUpload.value = "";

        // reset UI
        if (fileCount) fileCount.textContent = "";

        sendButton.disabled = true;
      }
    }
  );

});