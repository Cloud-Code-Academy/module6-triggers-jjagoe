/**
* Opportunity Trigger 
* @author John Jagoe
*/
trigger OpportunityTrigger on Opportunity (before update, before delete) {
    // Validate that the amount is greater than 5000.
    //  Prevent the deletion of a closed won opportunity for a banking account.
    // Set the primary contact on the opportunity to the contact with the title of CEO.
    
    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
          OpportunityTriggerHelper.beforeUpdate(Trigger.new);
        }
      }
    
      if (Trigger.isDelete) {
        if (Trigger.isBefore) {
          OpportunityTriggerHelper.beforeDelete(Trigger.old);
        }
      }

}