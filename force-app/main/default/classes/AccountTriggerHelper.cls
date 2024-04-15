/**
* Account Trigger Helper Class 
* @author John Jagoe
*/

public with sharing class AccountTriggerHelper {
    public static void beforeInsert(List<Account> newAccounts) {

        // Set the account type to prospect
        for(Account acct : newAccounts) {
            if(String.isBlank(acct.Type)){
                acct.Type = 'Prospect';
            }
        }
    
    
        // Copy the shipping address to the billing address.
        for(Account account : newAccounts) {
            //Use null-coalescing operator ??, which returns the left-hand operand if it's not null, 
            //otherwise it returns the right-hand operand.
            account.BillingStreet = account.ShippingStreet ?? '';
            account.BillingCity = account.ShippingCity ?? '';
            account.BillingState = account.ShippingState ?? '';
            account.BillingPostalCode = account.ShippingPostalCode ?? '';
            account.BillingCountry = account.ShippingCountry ?? '';
        }
   
        // Copy the shipping address to the billing address.
        for(Account account : newAccounts) {
            if(account.Fax != null && account.Phone != null && account.Website != null){
                account.Rating = 'Hot';
            }
        }
    }

    public static void afterInsert(List<Account> newAccounts) {

       // List to hold the new contacts to be inserted
        List<Contact> newContacts = new List<Contact>();
        for(Account acc : newAccounts) {
            // Create a new contact with default values
            newContacts.add(new Contact(LastName = 'DefaultContact', Email = 'default@email.com', AccountId = acc.Id));
          
        }
       
       // Insert the new contacts
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true;
        dml.DuplicateRuleHeader.RunAsCurrentUser = true;
        Database.insert(newContacts, dml);
      }
    }
    
    
