trigger CustomRollupUsingMap on Contact(
  after insert,
  after delete,
  after undelete
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      RollupClass.afterInsert(Trigger.new);
    } else if (Trigger.isUndelete) {
      RollupClass.afterUndelete(Trigger.new);
    } else if (Trigger.isDelete) {
      RollupClass.afterDelete(Trigger.old);
    }
  }
}