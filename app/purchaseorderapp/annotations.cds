using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    Common.DefaultValuesFunction : 'getOrderDefaults',
    UI.HeaderInfo        : {
        TypeName      : 'POs',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://invenio-solutions.com/hs-fs/hubfs/invenio-colour.png?width=1768&height=626&name=invenio-colour.png'
    },

    UI.SelectionFields   : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        OVERALL_STATUS,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        CURRENCY,
        GROSS_AMOUNT

    ],
    UI.LineItem          : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Label : 'boost',
            Inline: true
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus,
            Criticality: ColorCode
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.CITY
        },
              {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.setOrderProcessing',
            Label : 'Process Order',
            Inline: false
        }

    ],
    UI.Facets            : [{
        $Type : 'UI.CollectionFacet',
        Label : 'PO Information',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.Identification',
                Label : 'More Info'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Prices',
                Target: '@UI.FieldGroup#prices',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Status Data',
                Target: '@UI.FieldGroup#status',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target: 'Items/@UI.LineItem',
                Label : 'PO Items',
            },
        ]
    }],
    UI.Identification   : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
            Label : 'Partner Key'
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
        }
    ],
    UI.FieldGroup #prices: {
        Label: 'Prices',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,

            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT

            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT

            }
        ]
    },
    UI.FieldGroup #status: {
        Label: 'Status',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,

            },
            {
                $Type: 'UI.DataField',
                Value: OVERALL_STATUS

            }
        ]

    }
);

annotate service.POItem with @(
    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.DESCRIPTION,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        }
    ],
    UI.Facets        : [

    {
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.Identification',
        Label : 'More Detail'
    }, ],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        }
    ]

);

annotate service.POs with {
    PARTNER_GUID@(
        Common.ValueList.entity: 'CatalogService.BusinessPartnerSet'
    )
};

annotate service.POItem with {
    PRODUCT_GUID@(
        Common.ValueList.entity: 'CatalogService.ProductSet',
        Common.Text: PRODUCT_GUID.DESCRIPTION
    )
};


@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME
        }
    ]
);

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        }
    ]
);