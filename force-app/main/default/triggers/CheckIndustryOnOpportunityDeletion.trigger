trigger CheckIndustryOnOpportunityDeletion on Opportunity (before delete) {
    Set<Id> closedWonOpportunityIds = new Set<Id>();

    // Query closed won opportunities associated with banking accounts
    for (Opportunity opp : [SELECT Id, StageName, Account.Industry FROM Opportunity WHERE Id IN :Trigger.old AND IsWon = true AND StageName = 'Closed Won' AND Account.Industry = 'Banking']) {
        closedWonOpportunityIds.add(opp.Id);
    }

    // Iterate through the opportunities being deleted
    for (Opportunity opp : Trigger.old) {
     // Check if the opportunity is in the set of closed won opportunities associated with banking accounts
       if (closedWonOpportunityIds.contains(opp.Id)) {
           // Add an error to prevent the deletion
           opp.addError('Cannot delete closed opportunity for a banking account that is won');
       }
   }
 }