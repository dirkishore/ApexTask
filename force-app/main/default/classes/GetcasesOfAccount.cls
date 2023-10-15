public with sharing class GetcasesOfAccount {
  static List<Case> lstCase = new List<Case>();

  public static void getAccount() {
    lstCase = [SELECT Id, OwnerId, AccountId FROM Case];
  }

  public static void getAssociateCase() {
    Map<Id, Map<Id, List<Case>>> mapAssociateCases = new Map<Id, Map<Id, List<Case>>>();

    for (Case objCase : lstCase) {
      if (!(mapAssociateCases.containsKey(objCase.AccountId))) {
        mapAssociateCases.put(objCase.AccountId, new Map<Id, List<Case>>());

        if (
          !(mapAssociateCases.get(objCase.AccountId)
            .containsKey(objCase.OwnerId))
        ) {
          mapAssociateCases.get(objCase.AccountId)
            .put(objCase.OwnerId, new List<Case>());
          mapAssociateCases.get(objCase.AccountId)
            .get(objCase.OwnerId)
            .add(objCase);
        } else {
          mapAssociateCases.get(objCase.AccountId)
            .get(objCase.OwnerId)
            .add(objCase);
        }
      } else {
        mapAssociateCases.get(objCase.AccountId)
          .put(objCase.OwnerId, new List<Case>());
        mapAssociateCases.get(objCase.AccountId)
          .get(objCase.OwnerId)
          .add(objCase);
      }
    }
    System.debug(
      'GetcasesOfAccount getAssociateCase mapAssociateCases ' +
      mapAssociateCases
    );
  }
}