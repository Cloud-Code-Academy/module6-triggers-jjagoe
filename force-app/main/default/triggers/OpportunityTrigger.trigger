/**
* Opportunity Trigger 
* @author John Jagoe
*/
trigger OpportunityTrigger on Opportunity (before update, before delete) {
    // Validate that the amount is greater than 5000.
    //  Prevent the deletion of a closed won opportunity for a banking account.
    // Set the primary contact on the opportunity to the contact with the title of CEO.
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        
        // Get a list of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : Trigger.new) {
            accountIds.add(opp.AccountId);
        }

        // Query for Contacts with the Title of 'CEO' on these Accounts
        Map<Id, Contact> ceoContacts = new Map<Id, Contact>();
        for(Contact c : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO']) {
            ceoContacts.put(c.AccountId, c);
        }
        
        // Get a lists of Opportunity Account Ids and CEO Contacts
        //OpportunityTriggerHelper.getOpportunityAccountsAndCEOContacts(Trigger.new);

        // Validate that the amount is greater than 5000.
        OpportunityTriggerHelper.validateAmountGT5000OnOpportunity(Trigger.new);

        //Set the primary contact on the opportunity to the contact with the title of CEO.
        OpportunityTriggerHelper.SetPrimaryContactOnOpportunity(Trigger.new, ceoContacts);

    }    

    if (Trigger.isBefore && Trigger.isDelete) {
        
        //  Prevent the deletion of a closed won opportunity for a banking account.
        OpportunityTriggerHelper.StopClosedWonBankingOpportunity(Trigger.old);
        
    }

}