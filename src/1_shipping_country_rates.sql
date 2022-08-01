-- Creating the "shipping_country_rates" table
drop table if exists
    de.public.shipping_country_rates cascade;
create table
    de.public.shipping_country_rates
(
    shipping_country_id serial primary key,
    shipping_country text,
    shipping_country_base_rate numeric(14, 3)
);

-- Filling in the "shipping_country_rates" table
insert into
    de.public.shipping_country_rates (shipping_country, shipping_country_base_rate)
select
    distinct
    shipping_country::text,
    shipping_country_base_rate::numeric(14, 3)
from
    de.public.shipping;
