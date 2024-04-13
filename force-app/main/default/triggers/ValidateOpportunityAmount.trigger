trigger ValidateOpportunityAmount on Opportunity (before update) {
    // Iterate through the updated opportunities
    for(Opportunity opp : Trigger.new){
        // Check if the Opportunity amount is less than or equal to 5000
        if (opp.Amount <= 5000){
            // Add an error to the Opportunity record
            opp.addError('Opportunity amount must be greater than 5000');
        }
    }
}