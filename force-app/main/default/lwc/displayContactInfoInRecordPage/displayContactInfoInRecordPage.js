import { LightningElement, api, track, wire } from "lwc";

import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import getContacts from "@salesforce/apex/GetContactsOfAccount.getContacts";

import UpdateContact from "@salesforce/apex/UpdateContact.updateContact";

export default class DisplayContactInfoInRecordPage extends LightningElement {
  @api objectApiName;
  @api recordId;

  allDetails = [];

  @track contactLst = [];

  @wire(getContacts, { accountId: "$recordId" })
  lstContact({ data, error }) {
    if (data) {
      for (const lstContact of data) {
        const option = {
          label: lstContact.Name,
          value: lstContact.Id
        };
        this.contactLst = [...this.contactLst, option];
      }
    } else if (error) {
      console.error(error);
    }
  }

  get areaOfInterestOption() {
    return [
      { label: "Music", value: "Music" },
      { label: "Cooking", value: "Cooking" },
      { label: "Graphic design", value: "Graphic design" },
      { label: "Coding", value: "Coding" }
    ];
  }

  value = [];
  get languageKnownOption() {
    return [
      { label: "Tamil", value: "Tamil" },
      { label: "English", value: "English" },
      { label: "French", value: "French" },
      { label: "Hindi", value: "Hindi" }
    ];
  }

  get gradeOption() {
    return [
      { label: "A Grade", value: "Above 90" },
      { label: "B Grade", value: "Above 80" },
      { label: "C Grade", value: "Above 70" },
      { label: "D Grade", value: "Above 60" },
      { label: "E Grade", value: "Above 40" },
      { label: "F Grade", value: "Fail" }
    ];
  }

  detailsObject = [];
  handleInput(event) {
    const eve = event.target;
    this.detailsObject = {
      ...this.detailsObject,
      [event.target.name]: eve.value
    };
  }

  submitHandler() {
    this.allDetails = this.detailsObject;

    console.log("allDetails", JSON.stringify(this.allDetails));

    UpdateContact({
      contactId: this.allDetails.contact,
      areaOfInterest: this.allDetails.areaOfInterest,
      grade: this.allDetails.grade,
      languageKnown: this.allDetails.languageKnown
    })
      .then((result) => {
        console.log(result);
      })
      .catch((error) => {
        console.log(error);
      });

    const evt = new ShowToastEvent({
      title: "Submitted",
      message: "Submitted sucessful",
      variant: "success",
      mode: "dismissable"
    });
    this.dispatchEvent(evt);

    this.dispatchEvent(new CloseActionScreenEvent());
  }

  closeAction() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
}
