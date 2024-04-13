trigger ValidateOpportunityAmount on Opportunity (before update) {
    for(Opportunity opp : Trigger.new){
        if (opp.Amount <= 5000){
            // Add an error to the Opportunity record
            opp.addError('Opportunity amount must be greater than 5000');
        }
    }
}