trigger Task3 on Account(before update) {
  for (Account accObj : Trigger.new) {
    if (
      accObj.Rating == 'Warm' &&
      Trigger.oldMap.get(accObj.Id).Rating == 'Cold'
    ) {
      accObj.addError('you cannot change the rating from cold to warm');
    }
  }
}