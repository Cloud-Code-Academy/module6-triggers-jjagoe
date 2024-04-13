trigger CheckIndustryOnOpportunityDeletion on Opportunity (before delete) {
    // Query Opportunities to get Industry associated with Accounts.
    List<Opportunity> beforeOppsDelete = [SELECT Id, StageName, Account.Industry
                                         FROM Opportunity
                                         WHERE Id IN :Trigger.old];

    // Iterate through the opportunities being deleted
    for (Opportunity beforeOppDelete : beforeOppsDelete) {
        if (beforeOppDelete.StageName == 'Closed Won' && beforeOppDelete.Account.Industry == 'Banking') {
            Trigger.oldMap.Get(beforeOppDelete.Id).addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }
  }
 