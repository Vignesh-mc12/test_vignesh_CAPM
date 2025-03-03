using
{
    vignesh.db.master,
    vignesh.db.transaction
}
from '../db/datamodel';

using { CDSViews } from '../db/CDSViews';

@path : 'CatalogService'
service CatalogService
{
    annotate POs
    {
        OverallStatus
            @title : '{i18n>OVERALL_STATUS}';
    }

entity EmployeeSet @(restrict: [ 
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ]) as projection on master.employees;


    entity BusinessPartnerSet as
        projection on master.businesspartner;

    entity AddressSet as
        projection on master.address;

    entity ProductSet as
        projection on master.product;

    entity PurchaseOrderItems as
        projection on transaction.poitems;

    @odata.draft.enabled
    entity POs as
        projection on transaction.purchaseorder
        {
            case OVERALL_STATUS when 'P' then 'Pending' when 'A' then 'Approved' when 'X' then 'Rejected' else 'Open' end as OverallStatus : String(10),
            case OVERALL_STATUS when 'P' then 2 when 'A' then 3 when 'X' then 1 else 2 end as Zkas : Integer,
            *,
            Items : redirected to PurchaseOrderItems
        }
        actions
        {
            @Common.SideEffects : 
            {
                TargetProperties :
                [
                    'in/GROSS_AMOUNT'
                ]
            }
            action boost
            (
            )
            returns POs;
        };

    function getLargestOrder
    (
    )
    returns POs;

    action Action1
    (
    );
}
