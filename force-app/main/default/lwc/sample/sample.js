import { LightningElement, track } from "lwc";

export default class Sample extends LightningElement {
  @track firstName;
  handleName(event) {
    this.firstName = event.target.value;
  }

  handleSubmit() {
    this.template.querySelector("p").textContent = "Hello, " + this.firstName;
  }
}