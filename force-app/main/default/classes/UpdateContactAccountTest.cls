@isTest
public with sharing class UpdateContactAccountTest {
  @TestSetup
  static void makeData() {
    Account acc = new Account();
    acc.Name = 'Kishore';
    insert acc;

    Contact con = new Contact();
    con.FirstName = 'Balu';
    con.LastName = 'p';
    insert con;
  }
  @isTest
  static void testUpdateContactAccount() {
    Account acc1 = [SELECT Id, Name FROM Account WHERE Name = 'Kishore'];
    Contact con = [SELECT Id, name FROM Contact WHERE FirstName = :'Balu'];

    Test.startTest();
    UpdateContactAccount.updateContactAccount(
      con.Id,
      acc1.Id,
      new List<String>{ 'true' }
    );
    Test.stopTest();

    Contact conObj = [
      SELECT name, AccountId, Enrolled__c
      FROM Contact
      WHERE FirstName = :'Balu'
    ];
    Account accObj = [SELECT Id, Name FROM Account WHERE Name = 'Kishore'];

    System.assertEquals(conObj.AccountId, accObj.Id);
    System.assertEquals(conObj.Enrolled__c, true);
  }

  @isTest
  static void testCreatecase() {
    Account acc1 = [SELECT Id, Name FROM Account WHERE Name = 'Kishore'];
    Contact con = [SELECT Id, name FROM Contact WHERE FirstName = :'Balu'];

    Test.startTest();
    UpdateContactAccount.updateContactAccount(
      con.Id,
      acc1.Id,
      new List<String>{ 'true' }
    );

    Id caseId = UpdateContactAccount.createCase(con.Id, acc1.Id);
    Test.stopTest();

    for (Case caseObj : con.Cases) {
      system.assertEquals(caseObj.Id, caseId);
    }
  }
}
