/**
* The Opportunity Trigger Helper Class
* @author John Jagoe
*/

public with sharing class OpportunityTriggerHelper {

    public static void ValidateOpportunityAmount(List<Opportunity> opps) {

        // Validate that the amount is greater than 5000.
        for (Opportunity opp : opps) {

            if (opp.Amount <= 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void SetPrimaryContact(List<Opportunity> opps, Map<Id, Contact> ceoContacts) {

        //Set the primary contact on the opportunity to the contact with the title of CEO.
        for (Opportunity opp : opps) {

            if(ceoContacts.containsKey(opp.AccountId)) {
                opp.Primary_Contact__c = ceoContacts.get(opp.AccountId).Id;
            }
        }
    }

    public static void CheckIndustryOnOpportunityDeletion(List<Opportunity> oldOpps) {

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