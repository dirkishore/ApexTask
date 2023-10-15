import { LightningElement, api } from "lwc";

export default class DisplayNameFromParent extends LightningElement {
  @api userName;
}