trigger CreateDefaultContact on Account (after insert) {
    for (Account acct : Trigger.new){
        Contact cont = new Contact();
        cont.LastName  = 'DefaultContact';
        cont.Email = 'default@email.com';
        cont.AccountId  = acct.Id;
        insert cont;

    }
}