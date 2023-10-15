import { LightningElement, api } from "lwc";

export default class DisplayNameFromParentInChildTwo extends LightningElement {
  @api getNameFromParent;
}