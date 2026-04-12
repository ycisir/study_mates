// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "channels"


document.addEventListener("turbo:load", () => {

  const avatarInput = document.getElementById("avatar-upload");

  if (!avatarInput) return;

  avatarInput.addEventListener("change", () => {

    const file = avatarInput.files[0];

    if (!file) return;

    const sizeInMB = file.size / 1024 / 1024;

    if (sizeInMB > 1) {
      alert("Maximum avatar size is 1MB. Please choose a smaller image.");

      avatarInput.value = "";

      return;
    }

  });

});