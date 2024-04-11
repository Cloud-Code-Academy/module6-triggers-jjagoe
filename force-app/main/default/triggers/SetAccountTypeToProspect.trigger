trigger SetAccountTypeToProspect on Account (before insert) {
    for(Account acct : Trigger.new){
        if(String.isBlank(acct.Type)){
            acct.Type = 'Prospect';
        }
    }
}