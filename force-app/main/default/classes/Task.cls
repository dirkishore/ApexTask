public with sharing class Task {
  static List<Account> lstAcc1 = new List<Account>();
  static List<Account> lstAcc2 = new List<Account>();
  static List<Account> lstAcc3 = new List<Account>();
  static List<Id> lstAcc4;
  static List<Account> lstAcc5 = new List<Account>();

  static Set<Id> accountIdSet = new Set<Id>();
  static Set<Id> set2 = new Set<Id>();

  static Map<Id, Account> accMap = new Map<Id, Account>();

  //1st
  public static void firstQuestion() {
    lstAcc1 = [SELECT Id, Name FROM Account LIMIT 10];
    System.debug('1) List1 ' + lstAcc1);
  }

  //2nd
  public static void secondQuestion() {
    Integer count = 10;

    for (Integer i = 1; i <= lstAcc1.size(); i++) {
      if (!(Math.mod(i, 2) == 0)) {
        lstAcc2.add(lstAcc1.get(i - 1));
      }
    }

    for (Integer i = 0; i < lstAcc2.size(); i++) {
      if (lstAcc2.get(i) == lstAcc1.get(i)) {
        lstAcc1.remove(i);
      }
    }

    System.debug('2) List 1 ' + lstAcc1);
    System.debug('2) List 2 ' + lstAcc2);
  }

  //3rd
  public static void thirdQuestion() {
    if (!(lstAcc1.isEmpty() && lstAcc2.isEmpty())) {
      lstAcc3.addAll(lstAcc1);
      lstAcc3.addAll(lstAcc2);

      System.debug('3) List3 ' + lstAcc3);
    }
  }

  //4th
  public static void fourthQuestion() {
    for (Account accObj : lstAcc3) {
      accountIdSet.add(accObj.Id);
    }

    System.debug('4) Account Ids From Set 1 ' + accountIdSet);
  }

  //5th
  public static void fifthQuestion() {
    System.debug('5th question');
    for (Integer i = 0; i < lstAcc2.size(); i++) {
      if (!(accountIdSet.contains(lstAcc2.get(i).Id))) {
        System.debug(
          '5) Account Ids not Available in List2' + lstAcc2.get(i).Id
        );
      }
    }
  }

  //6th
  public static void sixthQuestion() {
    for (Integer i = 0; i < lstAcc1.size(); i++) {
      accountIdSet.remove(lstAcc1.get(i).Id);
    }

    System.debug('6th. Account Ids after Removing List 1 Ids: ' + accountIdSet);
  }

  //7th
  public static void seventhQuestion() {
    for (Account objAcc : lstAcc3) {
      accMap.put(objAcc.Id, objAcc);
    }

    System.debug('7) Mapping Id and Account ' + accMap);
  }

  //8th
  public static void eighthQuestion() {
    if ((accMap.keySet().containsAll(accountIdSet))) {
      set2.addAll(accountIdSet);
    }

    System.debug('8) Set2: ' + set2);
  }

  //9th
  public static void ninthQuestion() {
    for (Integer i = 0; i < accMap.size(); i++) {
      if (accMap.keySet().contains(lstAcc2.get(i).Id)) {
        accMap.remove(lstAcc2.get(i).Id);
      }
    }

    System.debug('9) Map 1: ' + accMap);
  }

  //10th
  public static void tenthQuestion() {
    lstAcc4 = new List<Id>(accMap.keySet());

    System.debug('10th question: ' + lstAcc4);
  }

  //11th
  public static void elevelthQuestion() {
    for (Account objacc : accMap.values()) {
      lstAcc5.add(objacc);
    }
    // lstAcc5 = accMap.values();
    System.debug('Elevelth Question: List 5 ' + lstAcc5);
  }

  //12th
  public static void twelveth() {
    System.debug('List 1 Size ' + lstAcc1.size());
    System.debug('List 2 Size ' + lstAcc2.size());

    System.debug('set 1 Size: ' + accountIdSet.size());
    System.debug('set 2 Size: ' + set2.size());

    lstAcc1.clear();
    lstAcc2.clear();

    accountIdSet.clear();
    set2.clear();
  }
}