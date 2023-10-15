@isTest
public with sharing class UpdateContactTest {
  @TestSetup
  static void makeData() {
    Contact conObj = new Contact();
    conObj.FirstName = 'Kishore';
    conObj.LastName = 'S';
    Database.insert(conObj);
  }

  @isTest
  static void contactTest() {
    Contact con = [
      SELECT Name, Grade__c, Area_of_Interest__c, Language_Known__c
      FROM Contact
      WHERE FirstName = :'Kishore'
    ];

    String contactId = con.Id;
    List<String> areaOfInterest = new List<String>{ 'Music', 'Coding' };
    String grade = 'Above 90';
    List<String> languageKnown = new List<String>{ 'Tamil', 'English' };

    Test.startTest();
    UpdateContact.updateContact(
      contactId,
      areaOfInterest,
      grade,
      languageKnown
    );
    Test.stopTest();

    Contact conObj = [
      SELECT Name, Grade__c, Area_of_Interest__c, Language_Known__c
      FROM Contact
      WHERE FirstName = :'Kishore'
    ];

    system.assertEquals('Music, Coding', conObj.Area_of_Interest__c);
    system.assertEquals('Above 90', conObj.Grade__c);
    system.assertEquals('Tamil, English', conObj.Language_Known__c);
  }
}
