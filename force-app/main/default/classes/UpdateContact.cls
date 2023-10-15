public with sharing class UpdateContact {
  @AuraEnabled
  public static void updateContact(
    String contactId,
    List<String> areaOfInterest,
    String grade,
    List<String> languageKnown
  ) {
    Contact contactVar = new Contact();
    contactVar.Id = contactId;
    contactVar.Grade__c = grade;

    for (String var : areaOfInterest) {
      if (contactVar.Area_of_Interest__c != null) {
        contactVar.Area_of_Interest__c += ', ' + var;
      } else {
        contactVar.Area_of_Interest__c = var;
      }
    }

    for (String var : languageKnown) {
      if (contactVar.Language_Known__c != null) {
        contactVar.Language_Known__c += ', ' + var;
      } else {
        contactVar.Language_Known__c = var;
      }
    }

    Database.update(contactVar);
  }
}
