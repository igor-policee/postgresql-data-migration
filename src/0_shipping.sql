-- Creating the "shipping" table
drop table if exists
    de.public.shipping cascade;

create table
    de.public.shipping
(
    ID                                 serial,
    shippingid                         BIGINT,
    saleid                             BIGINT,
    orderid                            BIGINT,
    clientid                           BIGINT,
    payment_amount                     NUMERIC(14, 2),
    state_datetime                     TIMESTAMP,
    productid                          BIGINT,
    description                        text,
    vendorid                           BIGINT,
    namecategory                       text,
    base_country                       text,
    status                             text,
    state                              text,
    shipping_plan_datetime             TIMESTAMP,
    hours_to_plan_shipping             NUMERIC(14, 2),
    shipping_transfer_description      text,
    shipping_transfer_rate             NUMERIC(14, 3),
    shipping_country                   text,
    shipping_country_base_rate         NUMERIC(14, 3),
    vendor_agreement_description       text,
    PRIMARY KEY (ID)
);
CREATE INDEX
    shippingid ON public.shipping (shippingid);
COMMENT ON COLUMN
    public.shipping.shippingid is 'id of shipping of sale';

-- Loading data from an external shipping.csv source into the "shipping" table (using a script or using a client)
COPY
    shipping
FROM
    'https://filedn.com/lAv70NoRi0O8LpU8BzbIRXJ/img/shipping.csv'
DELIMITER
    ','
CSV HEADER;
