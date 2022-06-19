-- 3.1. Создание таблицы "shipping_transfer"
drop table if exists
    de.public.shipping_transfer cascade;
create table
    de.public.shipping_transfer
(
    transfer_type_id serial primary key,
    transfer_type text,
    transfer_model text,
    shipping_transfer_rate numeric(14, 3)
);

-- 3.2. Заполнение таблицы "shipping_agreement"
insert into
    de.public.shipping_transfer (transfer_type, transfer_model, shipping_transfer_rate)
select
    distinct
    split_part(shipping_transfer_description, ':', 1)::text as "transfer_type",
    split_part(shipping_transfer_description, ':', 2)::text as "transfer_model",
    shipping_transfer_rate::numeric(14, 3) as "shipping_transfer_rate"
from
    de.public.shipping;
