import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["spinner", "buttonText"];

  connect() {
    console.log("Hello from download_button_controller.js");
  }

  handleClick() {
    this.originalText = this.buttonTextTarget.innerText;
    this.spinnerTarget.classList.remove("d-none");
    this.buttonTextTarget.innerText = "Loading...";
    setTimeout(this.resetButton.bind(this), 3000);
  }

  resetButton() {
    this.spinnerTarget.classList.add("d-none");
    this.buttonTextTarget.innerText = this.originalText;
  }
}
