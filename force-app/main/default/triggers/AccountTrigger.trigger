/**
* Account Trigger 
* @author John Jagoe
*/

trigger AccountTrigger on Account (before insert, after insert) {
    if (Trigger.IsBefore && Trigger.IsInsert) {
        // Set the account type to prospect
        AccountTriggerHelper.SetAccountTypeToProspect(Trigger.new);
        
        // Copy the shipping address to the billing address.
        AccountTriggerHelper.CopyShippingAddressToBilling(Trigger.new);

        // Set the Account Rating to Hot
        AccountTriggerHelper.SetAccountRating(Trigger.new);

    }
    
    if (Trigger.IsAfter && Trigger.IsInsert) {
        
        // Create a contact for each account inserted
        AccountTriggerHelper.CreateDefaultContact(Trigger.new);
        
    }

}