trigger CopyShippingAddressToBilling on ACCOUNT (before insert) {
    for(Account account : Trigger.new){
        account.BillingStreet = account.ShippingStreet ?? '';
        account.BillingCity = account.ShippingCity ?? '';
        account.BillingState = account.ShippingState ?? '';
        account.BillingPostalCode = account.ShippingPostalCode ?? '';
        account.BillingCountry = account.ShippingCountry ?? '';
    }
}