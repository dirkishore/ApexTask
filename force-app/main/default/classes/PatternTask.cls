public with sharing class PatternTask {
  public static void diamondPattern() {
    List<String> var = new List<String>();
    for (Integer i = 4; i > 0; i--) {
      for (Integer j = 0; j <= i; j++) {
        var.add(' ');
      }
      for (Integer z = 4; z >= i; z--) {
        var.add('* ');
      }
      System.debug(var);
      var.clear();
    }
    for (Integer i = 0; i < 5; i++) {
      for (Integer j = 0; j <= i; j++) {
        var.add(' ');
      }
      for (Integer z = 4; z >= i; z--) {
        var.add('* ');
      }
      System.debug(var);
      var.clear();
    }
  }

  public static void floydsTriangle() {
    List<Integer> num = new List<Integer>();
    Integer k = 1;
    for (Integer i = 1; i <= 4; ++i) {
      for (Integer j = 0; j < i; ++j) {
        num.add(k);
        k++;
      }

      System.debug(num);
      num.clear();
    }
  }
}