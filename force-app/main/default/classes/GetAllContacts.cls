public with sharing class GetAllContacts {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getAllContacts() {
    return [SELECT Id, Name FROM Contact WHERE Enrolled__c = FALSE];
  }
}
