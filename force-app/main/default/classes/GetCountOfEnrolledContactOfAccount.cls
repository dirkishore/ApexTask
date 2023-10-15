public with sharing class GetCountOfEnrolledContactOfAccount implements Database.Batchable<sObject> {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT Id, (SELECT Id FROM Contacts WHERE Enrolled__c=true) FROM Account'
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> acc) {
    for (Account a : acc) {
      a.No_Of_Enrolled_Contacts__c = a.Contacts.size();
    }
    update acc;
  }

  public void finish(Database.BatchableContext bc) {
  }
}
