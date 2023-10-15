import { LightningElement, api } from "lwc";

const columns = [
  { label: "Name", fieldName: "Name" },
  { label: "Age", fieldName: "Age" },
  { label: "Gender", fieldName: "Gender" }
];

export default class DisplayDataInTable extends LightningElement {
  @api tableData;
  columns = columns;
  showDataBol = true;

  connectedCallback() {
    console.log("table data", JSON.stringify(this.tableData));
  }

  showFormHandler() {
    this.showDataBol = !this.showDataBol;
    const showForm = new CustomEvent("showform");
    this.dispatchEvent(showForm);
  }
}