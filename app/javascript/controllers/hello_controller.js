import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name"];

  connect() {
    // this.element.textContent = "Hello World!"
    console.log("Helllooooo Worldddd !!!");
  }

  getUserName = () => {
    const element = this.nameTarget;
    const name = element.textContent;
    alert (`You clicked on ${name}`);
  };
}
