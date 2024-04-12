trigger CopyShippingAddressToBilling on ACCOUNT (before insert) {
    for(Account account : Trigger.new){
        //Use null-coalescing operator ??, which returns the left-hand operand if it's not null, 
        //otherwise it returns the right-hand operand.
        account.BillingStreet = account.ShippingStreet ?? '';
        account.BillingCity = account.ShippingCity ?? '';
        account.BillingState = account.ShippingState ?? '';
        account.BillingPostalCode = account.ShippingPostalCode ?? '';
        account.BillingCountry = account.ShippingCountry ?? '';
    }
}