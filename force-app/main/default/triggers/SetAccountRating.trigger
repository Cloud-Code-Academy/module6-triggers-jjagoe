trigger SetAccountRating on Account (before insert) {
    for (Account account : Trigger.new){
        if(account.Fax != null && account.Phone != null && account.Website != null){
            account.Rating = 'Hot';
        }
    }
}