import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.closeSearch = (event) => {
      if (!this.element.contains(event.target)) {
        document.getElementById("search_results").innerHTML = ""
      }
    }

    document.addEventListener("click", this.closeSearch)
    // console.log("debounce controller connected.")
  }

  disconnect() {
    document.removeEventListener("click", this.closeSearch)
  }

  static targets = ["form"]
  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 500)
  }
}
