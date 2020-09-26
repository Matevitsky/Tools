/**
 * Created by Sergey on 22.09.2020.
 */

trigger AccountTrigger on Account (before insert, before update, before delete,
    after insert, after update, after delete, after undelete ) {
    if (Trigger.isUpdate && Trigger.isAfter) {
    } else if (Trigger.isInsert && Trigger.isBefore) {
        AccountTriggerHandler.beforeInsert(Trigger.new);
    } else if (Trigger.isInsert && Trigger.isAfter) {

    } else if (Trigger.isUpdate && Trigger.isBefore) {

    } else if (Trigger.isDelete && Trigger.isBefore) {

    } else if (Trigger.isDelete && Trigger.isAfter) {

    } else if (Trigger.isUndelete && Trigger.isAfter) {

    }
}
