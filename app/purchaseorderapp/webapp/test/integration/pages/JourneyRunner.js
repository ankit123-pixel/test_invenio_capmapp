sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"inv/purchaseorderapp/test/integration/pages/POsList",
	"inv/purchaseorderapp/test/integration/pages/POsObjectPage",
	"inv/purchaseorderapp/test/integration/pages/POItemObjectPage"
], function (JourneyRunner, POsList, POsObjectPage, POItemObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('inv/purchaseorderapp') + '/test/flp.html#app-preview',
        pages: {
			onThePOsList: POsList,
			onThePOsObjectPage: POsObjectPage,
			onThePOItemObjectPage: POItemObjectPage
        },
        async: true
    });

    return runner;
});

