import { LightningElement, api, track, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { CloseActionScreenEvent } from "lightning/actions";

import getAllContacts from "@salesforce/apex/GetAllContacts.getAllContacts";
import updateContactAccount from "@salesforce/apex/UpdateContactAccount.updateContactAccount";
import createCase from "@salesforce/apex/UpdateContactAccount.createCase";

export default class ContactReparenting extends LightningElement {
  @api recordId;
  @api objectApiName;

  @track allContacts = [];
  selectedContact;
  enrollment = [];
  caseId;

  @wire(getAllContacts) contactLst({ data, error }) {
    if (data) {
      for (const contact of data) {
        let object = {
          label: contact.Name,
          value: contact.Id
        };
        this.allContacts = [...this.allContacts, object];
      }
    } else if (error) {
      console.log(JSON.stringify(error));
    }
  }

  contactHandler(event) {
    this.selectedContact = event.target.value;
    // console.log(this.selectedContact);
  }

  changeAccount() {
    updateContactAccount({
      contactId: this.selectedContact,
      accountId: this.recordId,
      enrollment: this.enrollment
    })
      .then(() => {
        createCase({
          contactId: this.selectedContact,
          accountId: this.recordId
        })
          .then((res) => {
            console.log("Case created", res);
            this.caseId = res;
            // this.dispatchEvent(new CloseActionScreenEvent());
          })
          .catch((error) => {
            console.log("error", error);
          });
      })
      .catch((error) => {
        console.log("error", error);
      });
  }

  viewCase() {
    console.log("called", this.caseId);
    this.dispatchEvent(new CloseActionScreenEvent());

    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.caseId,
        objectApiName: "Case",
        actionName: "view"
      }
    });
  }

  enrollmentHandler(event) {
    this.enrollment = event.target.value;
  }

  get checkBoxOption() {
    return [{ label: "Enroll", value: "true" }];
  }
}
