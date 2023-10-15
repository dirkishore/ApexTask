import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class GetDataAndDisplayInTable extends LightningElement {
  get genderOption() {
    return [
      { label: "Male", value: "Male" },
      { label: "Female", value: "Female" }
    ];
  }

  Name;
  Age;
  Gender;
  showDataBol = false;
  showForm = true;

  userData = [];

  handleName(event) {
    this.Name = event.target.value;
  }
  handleAge(event) {
    this.Age = event.target.value;
  }
  handleGender(event) {
    this.Gender = event.target.value;
  }

  handleSubmit() {
    if (this.Name && this.Age && this.Gender) {
      this.userData.push({
        Name: this.Name,
        Age: this.Age,
        Gender: this.Gender
      });

      this.Name = "";
      this.Age = "";
      this.Gender = "";

      const evt = new ShowToastEvent({
        title: "Submitted",
        message: "Submitted sucessful",
        variant: "success",
        mode: "dismissable"
      });
      this.dispatchEvent(evt);
    } else {
      const evt = new ShowToastEvent({
        title: "Enter all fields",
        message: "All fields must be entered",
        variant: "error",
        mode: "dismissable"
      });
      this.dispatchEvent(evt);
    }
  }

  showDataHandler() {
    this.showDataBol = !this.showDataBol;
    this.showForm = !this.showForm;
  }

  showFormHandler() {
    this.showForm = !this.showForm;
    this.showDataBol = !this.showDataBol;
  }
}