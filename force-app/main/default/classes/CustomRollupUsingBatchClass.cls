public with sharing class CustomRollupUsingBatchClass implements Database.Batchable<sObject> {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT Id, (SELECT Id FROM Contacts) FROM Account'
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> lstAccounts) {
    for (Account accVar : lstAccounts) {
      accVar.NoOfContacts__c = accVar.contacts.size();
    }

    Database.update(lstAccounts);
    system.debug('job Id==>' + bc);
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('Finised' + bc);
  }
}