trigger SetPrimaryContact on Opportunity (before update) {
    //Get Account Ids from Opportunities.
    Set<Id> accountIds = new Set<Id>();
    for (Opportunity oppAccountIds : Trigger.new) {
        accountIds.add(oppAccountIds.AccountId);
    }

    //Get Contacts where Title = CEO.
    List<Contact> ceoContacts = [
        SELECT Id, Title, AccountId
        FROM Contact
        WHERE AccountId IN :accountIds AND Title = 'CEO'];

    //Map Account Id with Contact.
    Map<Id,Contact> primaryContacts = new Map<Id,Contact>();
    for (Contact ceoContact : ceoContacts) {
        primaryContacts.put(ceoContact.AccountId, ceoContact);
    }  
    
    //Loop through each Opportunity before is updated
    for (Opportunity beforeOppUpdate : Trigger.new) {
        //Populate Primary Contact on Opportunity.
        if (beforeOppUpdate.AccountId != null) {
            beforeOppUpdate.Primary_Contact__c = primaryContacts.get(beforeOppUpdate.AccountId).Id;
        }
    }
}