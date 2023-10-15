public with sharing class RollupClass {
  public static void afterInsert(List<Contact> contact) {
    Map<Id, List<Contact>> mapContact = new Map<Id, List<Contact>>();

    Set<Id> accIds = new Set<Id>();

    for (Contact accVar : contact) {
      accIds.add(accVar.AccountId);
    }

    list<Contact> lstCon = [
      // SELECT id, (SELECT id FROM Contacts)
      // FROM Account
      // WHERE Id IN :accIds
      SELECT Id, Account.Id
      FROM Contact
      WHERE AccountId IN :accIds
    ];

    for (Contact conObj : lstCon) {
      if (!mapContact.containsKey(conObj.AccountId)) {
        mapContact.put(conObj.AccountId, new List<Contact>());
      }
      mapContact.get(conObj.AccountId).add(conObj);
    }

    Account accVar = new Account();
    for (Contact conObj : lstCon) {
      Integer count = mapContact.get(conObj.AccountId).size();
      accVar.Id = conObj.AccountId;
      accVar.NoOfContacts__c = count;
    }

    update accVar;
  }

  public static void afterUndelete(List<Contact> contact) {
    Map<Id, List<Contact>> mapContact = new Map<Id, List<Contact>>();

    Set<Id> accIds = new Set<Id>();

    for (Contact contactVar : contact) {
      accIds.add(contactVar.AccountId);
    }

    list<Account> lstAcc = [
      SELECT id, (SELECT id FROM Contacts)
      FROM Account
      WHERE Id IN :accIds
    ];

    for (Account accObj : lstAcc) {
      if (!mapContact.containsKey(accObj.Id)) {
        mapContact.put(accObj.Id, new List<Contact>());
      }
      mapContact.get(accObj.Id).addAll(accObj.Contacts);
    }

    for (Account accObj : lstAcc) {
      accObj.NoOfContacts__c = accObj.Contacts.size();
    }

    update lstAcc;
  }

  public static void afterDelete(List<Contact> contact) {
    Map<Id, List<Contact>> mapContact = new Map<Id, List<Contact>>();

    Set<Id> accIds = new Set<Id>();

    for (Contact contactVar : contact) {
      accIds.add(contactVar.AccountId);
    }

    list<Account> lstAcc = [
      SELECT id, (SELECT id FROM Contacts)
      FROM Account
      WHERE Id IN :accIds
    ];

    for (Account accObj : lstAcc) {
      if (!mapContact.containsKey(accObj.Id)) {
        mapContact.put(accObj.Id, new List<Contact>());
        mapContact.get(accObj.Id).addAll(accObj.Contacts);
      } else {
        mapContact.get(accObj.Id).addAll(accObj.Contacts);
      }
    }

    for (Account accObj : lstAcc) {
      accObj.NoOfContacts__c = accObj.Contacts.size();
    }

    update lstAcc;
  }
}