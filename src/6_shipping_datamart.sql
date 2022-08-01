-- Creating and filling in the "shipping_datamart" view
create or replace view
    de.public.shipping_datamart as
select
    si.shippingid::bigint as "shippingid",
    si.vendorid::bigint as "vendorid",
    st.transfer_type::text as "transfer_type",
    extract(day from age(ss.shipping_end_fact_datetime, ss.shipping_start_fact_datetime))::int  as "full_day_at_shipping",
    (ss.shipping_end_fact_datetime > si.shipping_plan_datetime)::bool as "is_delay",
    case
        when ss.status = 'finished' then true else false
    end::bool as "is_shipping_finish",
    case
        when extract(day from age(ss.shipping_end_fact_datetime, si.shipping_plan_datetime)) <= 0 then 0
            else extract(day from age(ss.shipping_end_fact_datetime, si.shipping_plan_datetime))
    end::int as "delay_day_at_shipping",
    si.payment_amount::numeric(14, 2) as "payment_amount",
    (si.payment_amount * (scr.shipping_country_base_rate + sa.agreement_rate + st.shipping_transfer_rate))::numeric as "vat",
    (si.payment_amount * sa.agreement_commission)::numeric as "profit"
from
    de.public.shipping_info as si
    inner join de.public.shipping_transfer as st
        on si.transfer_type_id = st.transfer_type_id
    inner join de.public.shipping_status as ss
        on si.shippingid = ss.shippingid
    inner join de.public.shipping_country_rates as scr
        on si.shipping_country_id = scr.shipping_country_id
    inner join de.public.shipping_agreement as sa
        on si.agreementid = sa.agreementid;
