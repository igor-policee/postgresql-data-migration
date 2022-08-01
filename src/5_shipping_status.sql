-- Creating the "shipping_status" table
drop table if exists
    de.public.shipping_status cascade;
create table
    de.public.shipping_status
(
    shippingid bigint,
    status text,
    state text,
    shipping_start_fact_datetime timestamp,
    shipping_end_fact_datetime timestamp
);

-- Filling in the "shipping_status" table
insert into
    de.public.shipping_status
    (shippingid, status, state, shipping_start_fact_datetime, shipping_end_fact_datetime)

with max_dt_cte as
(
    select
        shippingid,
        max(state_datetime::timestamp) as "state_datetime_max"
    from
        de.public.shipping
    group by
        shippingid
),

state_booked_cte as
(
    select
        shippingid,
        state_datetime::timestamp as "shipping_start_fact_datetime"
    from
        de.public.shipping
    where
        state = 'booked'
),

state_recieved_cte as
(
    select
        shippingid,
        state_datetime::timestamp as "shipping_end_fact_datetime"
    from
        de.public.shipping
    where
        state = 'recieved'
)

select
    mdc.shippingid::bigint as "shippingid",
    s.status::text as "status",
    s.state::text as "state",
    sbc.shipping_start_fact_datetime::timestamp as "shipping_start_fact_datetime",
    src.shipping_end_fact_datetime::timestamp as "shipping_end_fact_datetime"
from
    max_dt_cte as mdc
    inner join de.public.shipping as s
        on mdc.state_datetime_max = s.state_datetime
    left join state_booked_cte as sbc
        on mdc.shippingid = sbc.shippingid
    left join state_recieved_cte as src
        on mdc.shippingid = src.shippingid
