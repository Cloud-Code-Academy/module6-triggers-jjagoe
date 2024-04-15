/**
* Account Trigger 
* @author John Jagoe
*/

trigger AccountTrigger on Account (before insert, after insert) {
    
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
          
          AccountTriggerHelper.beforeInsert(Trigger.new);

        } else if (Trigger.isAfter) {

          AccountTriggerHelper.afterInsert(Trigger.new);
        }
      }

}