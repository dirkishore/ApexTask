public with sharing class GetAccountsByRating {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts(String strRating) {
    return [SELECT Id, Name, Rating FROM Account WHERE Rating = :strRating];
  }
}