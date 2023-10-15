trigger CustomRollup on Contact(after insert, before delete) {
  if (Trigger.isInsert) {
    Set<Id> accIds = new Set<Id>();

    for (Contact conVar : Trigger.new) {
      accIds.add(conVar.AccountId);
    }

    List<Account> contactObj = [
      SELECT Id, NoOfContacts__c, (SELECT Id FROM Contacts)
      FROM Account
      WHERE Id IN :accIds
    ];

    for (Account accvar : contactObj) {
      accVar.NoOfContacts__C = accvar.Contacts.size();
    }

    update contactObj;
  } else if (Trigger.isDelete) {
    Set<Id> accIds = new Set<Id>();

    for (Contact conVar : Trigger.old) {
      accIds.add(conVar.AccountId);
    }

    List<Account> accountObj = [
      SELECT Id, NoOfContacts__c, (SELECT Id FROM Contacts)
      FROM Account
      WHERE Id IN :accIds
    ];

    for (Account accvar : accountObj) {
      accVar.NoOfContacts__c = accvar.Contacts.size() - 1;
    }

    update accountObj;
  }
}
