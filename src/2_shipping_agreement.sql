-- Creating the "shipping_agreement" table
drop table if exists
    de.public.shipping_agreement cascade;
create table
    de.public.shipping_agreement
(
    agreementid bigint primary key ,
    agreement_number text,
    agreement_rate numeric(14, 2),
    agreement_commission numeric (14, 2)
);

-- Filling in the "shipping_agreement" table
insert into
    de.public.shipping_agreement (agreementid, agreement_number, agreement_rate, agreement_commission)
select
    distinct
    split_part(vendor_agreement_description, ':', 1)::bigint as "agreementid",
    split_part(vendor_agreement_description, ':', 2)::text as "agreement_number",
    split_part(vendor_agreement_description, ':', 3)::numeric(14, 2) as "agreement_rate",
    split_part(vendor_agreement_description, ':', 4)::numeric(14, 2) as "agreement_commission"
from
    de.public.shipping
order by
    agreementid asc
