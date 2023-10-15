trigger Sample on Account(
  before insert,
  before update,
  before delete,
  after insert,
  after update
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      for (Account accObj : Trigger.new) {
        if (accObj.Rating == null) {
          accObj.Rating = 'Hot';
        }
        accObj.Name += ' AWT';
      }
    } else if (Trigger.isUpdate) {
      for (Account accVar : Trigger.new) {
        accVar.Description = Datetime.now().format('yyyy/MM/dd hh:mm:ss');
      }
    } else {
      for (Account accObj : Trigger.old) {
        if (accObj.Name == 'Kishore S') {
          accObj.addError('You cannot delete this account');
        }
      }
    }
  } else {
    if (Trigger.isInsert) {
      List<Contact> lstContactToInsert = new List<Contact>();

      for (Account accObj : Trigger.new) {
        Contact conObj = new Contact();
        conObj.FirstName = accObj.Name;
        conObj.LastName = 'AWT';
        conObj.Phone = '1234567890';

        conObj.AccountId = accObj.Id;
        lstContactToInsert.add(conObj);
      }
      insert lstContactToInsert;
    } else if (Trigger.isUpdate) {
      List<Contact> lstAccountToUpdate = [
        SELECT ID
        FROM Contact
        WHERE AccountId IN :Trigger.new
      ];

      List<Contact> lstCon = new List<Contact>();

      for (Contact accObj : lstAccountToUpdate) {
        Contact conVar = new Contact(Id = accObj.Id);
        conVar.Phone = '123456789';
        lstCon.add(conVar);
      }

      update lstCon;
    }
  }
}