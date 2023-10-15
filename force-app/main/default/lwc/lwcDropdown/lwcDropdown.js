import { LightningElement } from "lwc";
import getAccounts from "@salesforce/apex/GetAccountsByRating.getAccounts";

export default class LwcDropdown extends LightningElement {
  ratingValue = "Hot";
  accountRecord = [];
  tableColumns = [
    { label: "Name", fieldName: "Name" },
    { label: "Rating", fieldName: "Rating" }
  ];
  loaded = false;

  get comboBoxOption() {
    return [
      { label: "Hot", value: "Hot" },
      { label: "Warm", value: "Warm" },
      { label: "Cold", value: "Cold" }
    ];
  }

  handleRating(event) {
    this.ratingValue = event.detail.value;
  }

  // @wire(getAccounts, { strRating: "$ratingValue" })
  // lstAccounts({ data, error }) {
  //   if (data) {
  //     this.accountRecord = data;
  //     this.loaded = true;
  //     console.log(this.accountRecord);
  //   } else {
  //     console.log(error);
  //   }
  // }

  connectedCallback() {
    getAccounts({ strRating: this.ratingValue })
      .then((result) => {
        this.accountRecord = result;
        this.loaded = true;
      })
      .catch((error) => {
        console.log(error);
      });
  }

  //imperative method
  refreshTable() {
    getAccounts({ strRating: this.ratingValue })
      .then((result) => {
        this.accountRecord = result;
        this.loaded = true;
      })
      .catch((error) => {
        console.log(error);
      });
  }
}