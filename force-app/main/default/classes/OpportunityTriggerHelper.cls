/**
* The Opportunity Trigger Helper Class
* @author John Jagoe
*/

public with sharing class OpportunityTriggerHelper {

    public static void beforeUpdate(List<Opportunity> updatedOpportunities) {

        // Validate that the amount is greater than 5000.
        for (Opportunity opp : updatedOpportunities) {

            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    
  
        //Set the primary contact on the opportunity to the contact with the title of CEO.
        List<Id> oppAcctIds = new List<Id>();
        for (Opportunity opp : updatedOpportunities) {
            if(opp.AccountId != null){
                oppAcctIds.add(opp.AccountId);
            }
            
        }

        if (oppAcctIds.size() > 0) {
            //Get Contacts where Title = CEO.
            List<Contact> ceoContacts = [SELECT Id, Title, AccountId
                                        FROM Contact
                                        WHERE AccountId IN :oppAcctIds AND Title = 'CEO'];
        
        // Create a Map of Account Id's and Contact objects
        Map<Id, Contact> acctIdContactMap = new Map<Id, Contact>();
        for (Contact con : ceoContacts) {
            acctIdContactMap.put(con.AccountId, con);
        }

        for (Opportunity opp : updatedOpportunities) {
            opp.Primary_Contact__c = acctIdContactMap.get(opp.AccountId).Id;
        }
    }
 }

    public static void beforeDelete(List<Opportunity> oldOpps) {

        // Get a list of Account Ids from the Opportunities to Delete
        Set<Id> delAccountIds = new Set<Id>();
        for (Opportunity opp : oldopps) {
            delAccountIds.add(opp.AccountId);
        }

        // Query for Accounts with the Industry of 'Banking' 
        Map<Id, Account> bankingAccounts = new Map<Id, Account>(
            [SELECT Id, Industry FROM Account WHERE Id IN :delAccountIds AND Industry = 'Banking']);

        //  Prevent the deletion of a closed won opportunity for a banking account.
        for (Opportunity oldOpp : oldopps) {

            if (oldOpp.StageName == 'Closed Won' && bankingAccounts.containsKey(oldOpp.AccountId)) {
                oldOpp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
}
