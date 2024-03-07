import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement", "icon"];

  connect() {
    console.log("Hey from toggle_controller.js");
  }

  fire(event) {
    event.preventDefault()
    this.togglableElementTarget.classList.toggle("d-none");
  }

  changeStatus() {
    this.element.setAttribute("aria-pressed", "true");
    this.iconTarget.classList.toggle("fa-regular");
    this.iconTarget.classList.add("fa-solid");
  }
}
