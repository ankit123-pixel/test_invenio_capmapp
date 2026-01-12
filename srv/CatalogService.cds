using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds} from '../db/CDSViews';


service CatalogService @(path:'CatalogService') {

    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity ProductSet as projection on master.product;
    entity POs @(odata.draft.enabled: true) as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
        when 'P' then 'Pending'
        when 'A' then 'Approved'
        when 'X' then 'Rejected'
        when 'N' then 'New'
        end  as OverallStatus : String(10),
        
        @UI.Hidden: true
        case OVERALL_STATUS
        when 'P' then '2'
        when 'A' then '3'
        when 'X' then '1'
        when 'N' then '2'
        end  as ColorCode : Integer
    }
    actions{
        @Common : { SideEffects : {
            $Type : 'Common.SideEffectsType',
            TargetProperties :[
                'in/GROSS_AMOUNT',
                'in/OVERALL_STATUS'
            ]
        }, }
        action boost();
        action setOrderProcessing();
    };
    function getOrderDefaults() returns POs;
    function getLargestOrder() returns POs;
    
    entity POItem as projection on transaction.poitems;
        

}