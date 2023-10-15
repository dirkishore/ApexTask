public with sharing class UpdateContactAccount {
  @AuraEnabled
  public static void updateContactAccount(
    String contactId,
    String accountId,
    List<String> enrollment
  ) {
    Contact con = [
      SELECT Id, Name, AccountId
      FROM Contact
      WHERE Id = :contactId
    ];
    con.AccountId = accountId;
    if (enrollment.contains('true')) {
      con.Enrolled__c = true;
    }

    update con;
  }

  @AuraEnabled
  public static Id createCase(String contactId, String accountId) {
    Contact con = [
      SELECT Id, Name, Enrolled__c
      FROM Contact
      WHERE Id = :contactId
    ];
    Case caseObj = new Case();
    if (con.Enrolled__c == true) {
      caseObj.ContactId = contactId;
      caseObj.AccountId = accountId;
      caseObj.Status = 'New';
      caseObj.Subject = 'New case create now';

      insert caseObj;
    }
    return caseObj.Id;
  }
}
