import { LightningElement } from "lwc";

export default class GetNameFromUser extends LightningElement {
  userName;
  handleName(event) {
    this.userName = event.target.value;
    console.log(this.userName);
  }
}