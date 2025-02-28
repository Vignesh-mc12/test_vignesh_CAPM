sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'mange/po/managepurchaseorder/test/integration/FirstJourney',
		'mange/po/managepurchaseorder/test/integration/pages/POsList',
		'mange/po/managepurchaseorder/test/integration/pages/POsObjectPage',
		'mange/po/managepurchaseorder/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('mange/po/managepurchaseorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);