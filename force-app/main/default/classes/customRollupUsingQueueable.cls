public with sharing class customRollupUsingQueueable implements Queueable {
  public void execute(QueueableContext context) {
    List<Account> lstAccounts = [
      SELECT Id, (SELECT Id FROM Contacts)
      FROM Account
    ];
    for (Account accVar : lstAccounts) {
      accVar.NoOfContacts__c = accVar.contacts.size();
    }

    Database.update(lstAccounts);
  }
}