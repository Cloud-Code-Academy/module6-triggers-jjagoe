trigger CreateDefaultContact on Account (after insert) {
    // List to hold the new contacts to be inserted
    List<Contact> newContacts = new List<Contact>();
    
    // Iterate through the inserted accounts
    for (Account acc : Trigger.new) {
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