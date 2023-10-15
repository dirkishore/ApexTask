@isTest(seeAllData=true)
public with sharing class CustomRollupUsingBatchClassTest {
  public Account setUp() {
    Account acc = new Account();
    acc.Name = 'Sample1';
    Database.insert(acc);

    Contact con = new Contact();
    con.AccountId = acc.Id;
    con.FirstName = acc.Name;
    con.LastName = 'contact';
    Database.insert(con);

    return acc;
  }
  @isTest
  static void checkContactsOfAccount() {
    CustomRollupUsingBatchClassTest setUpObj = new CustomRollupUsingBatchClassTest();
    Account acc = setUpObj.setUp();

    Test.startTest();
    CustomRollupUsingBatchClass obj = new CustomRollupUsingBatchClass();
    Database.executeBatch(obj);
    Test.stopTest();

    Account account = [
      SELECT id, Name, (SELECT Name FROM Contacts)
      FROM Account
      WHERE id = :acc.Id
    ];

    System.assertEquals(1, account.Contacts.size());
  }
}