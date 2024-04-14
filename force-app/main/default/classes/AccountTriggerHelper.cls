/**
* Account Trigger Helper Class 
* @author John Jagoe
*/

public with sharing class AccountTriggerHelper {
    public static void setAccountTypeToProspect(List<Account> newAccounts) {

        // Set the account type to prospect
        for(Account acct : newAccounts) {
            if(String.isBlank(acct.Type)){
                acct.Type = 'Prospect';
            }
        }
    }
    
    public static void CopyShippingAddressToBilling(List<Account> newAccounts) {

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
    }

    public static void SetAccountRating(List<Account> newAccounts) {

        // Copy the shipping address to the billing address.
        for(Account account : newAccounts) {
            if(account.Fax != null && account.Phone != null && account.Website != null){
                account.Rating = 'Hot';
            }
        }
    }

    public static void CreateDefaultContact(List<Account> newAccounts) {

        // Create a contact for each account inserted
       // List<Contact> contactsToInsert = new List<Contact>();
       // List to hold the new contacts to be inserted
         List<Contact> newContacts = new List<Contact>();
        for(Account acc : newAccounts) {
            // Create a new contact with default values
            Contact newContact = new Contact(
            LastName = 'DefaultContact',
            Email = 'default@email.com',
            AccountId = acc.Id // Set the AccountId to relate the contact to the account
        );
        // Add the new contact to the list
        newContacts.add(newContact);
        }
       // Insert the new contacts
       Database.DMLOptions dml = new Database.DMLOptions();
       dml.DuplicateRuleHeader.AllowSave = true;
       Database.insert(newContacts, dml);
    }
}