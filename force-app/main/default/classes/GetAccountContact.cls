public with sharing class GetAccountContact {
  Map<Id, List<Contact>> mapContact = new Map<Id, List<Contact>>();
  public void getAssociateContact() {
    List<Contact> lstContact = [SELECT Id, AccountId, Name FROM Contact];

    for (Contact objContact : lstContact) {
      if (!(mapContact.containsKey(objContact.AccountId))) {
        mapContact.put(objContact.AccountId, new List<Contact>());
        mapContact.get(objContact.AccountId).add(objContact);
      } else {
        mapContact.get(objContact.AccountId).add(objContact);
      }
    }
  }

  //get from mapContact
  public void getFromMapContact() {
    for (List<Contact> variable : mapContact.values()) {
      System.debug(variable);
    }
  }
}