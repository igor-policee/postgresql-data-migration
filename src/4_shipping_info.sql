-- 4.1. Создание таблицы "shipping_info"
drop table if exists
    de.public.shipping_info cascade;
create table
    de.public.shipping_info
(
    shippingid bigint,
    vendorid bigint,
    payment_amount numeric(14, 2),
    shipping_plan_datetime timestamp,
    transfer_type_id int,
    shipping_country_id int,
    agreementid bigint,
    foreign key (transfer_type_id) references de.public.shipping_transfer(transfer_type_id),
    foreign key (shipping_country_id) references de.public.shipping_country_rates(shipping_country_id),
    foreign key (agreementid) references de.public.shipping_agreement(agreementid)
);

-- 4.2. Заполнение таблицы "shipping_info"
insert into
    de.public.shipping_info
    (shippingid, vendorid, payment_amount, shipping_plan_datetime, transfer_type_id, shipping_country_id, agreementid)
select
    distinct
    s.shippingid::bigint,
    s.vendorid::bigint,
    s.payment_amount::numeric(14, 2),
    s.shipping_plan_datetime::timestamp,
    st.transfer_type_id::int,
    scr.shipping_country_id::int,
    sa.agreementid::bigint
from
    de.public.shipping as s
    inner join de.public.shipping_transfer as st
        on split_part(s.shipping_transfer_description, ':', 1)::text = st.transfer_type::text
        and split_part(s.shipping_transfer_description, ':', 2)::text = st.transfer_model::text
    inner join de.public.shipping_country_rates as scr
        on s.shipping_country::text = scr.shipping_country::text
    inner join de.public.shipping_agreement as sa
        on split_part(s.vendor_agreement_description, ':', 1)::bigint = sa.agreementid::bigint
