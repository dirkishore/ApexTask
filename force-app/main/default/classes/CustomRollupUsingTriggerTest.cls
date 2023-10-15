@isTest
public with sharing class CustomRollupUsingTriggerTest {
  @isTest
  static void checkContactsOfAccount() {
    Contact con = new Contact(FirstName = 'Kamal', LastName = 'S');

    Database.insert(con);

    // System.assertEquals(5, con.Account.Contacts.size());
  }
}