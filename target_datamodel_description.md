# Описание целевой модели данных

## Схема целевой модели данных

![Схема целевой модели данных](datamodel/target_datamodel_er.png)

## Структура таблиц

1. Справочник `public.shipping_country_rates`, содержащий уникальные пары соответствующих полей таблицы `public.shipping`:
+ `shipping_country_id` — первичный ключ. Тип данных: _serial_.
+ `shipping_country` — страна доставки. Тип данных: _text_.
+ `shipping_country_base_rate` — налог на доставку в страну, который является процентом от стоимости. Тип данных: _numeric(14, 3)_.

2. Справочник `public.shipping_agreement`, содержащий данные поля `vendor_agreement_description` таблицы `public.shipping`, разделенные знаком `:`:
+ `agreementid` — первичный ключ. Тип данных: _bigint_.
+ `agreement_number` — номер соглашения. Тип данных: _text_.
+ `agreement_rate` — ставка по соглашению. Тип данных: _numeric(14, 2)_.
+ `agreement_commission` — комиссия по соглашению. Тип данных: _numeric(14, 2)_.

3. Справочник `public.shipping_transfer`, содержащий данные поля `shipping_transfer_description` таблицы `public.shipping`, разделенные знаком `:`:
+ `transfer_type_id` — первичный ключ. Тип данных: _serial_.
+ `transfer_type` — тип доставки. Тип данных: _text_.
+ `transfer_model` — модель (способ) доставки. Тип данных: _text_.
+ `shipping_transfer_rate` — процент стоимости доставки. Тип данных: _numeric(14, 3)_.

4. Таблица `public.shipping_info`, содержащая уникальные идентификаторы доставки `shippingid` и связанная с созданными справочниками `public.shipping_country_rates`, `public.shipping_agreement`, `public.shipping_transfer` и константной информацией о доставке `shipping_plan_datetime`, `payment_amount`, `vendorid`:
+ `shippingid` — уникальный идентификатор доставки. Тип данных: _bigint_.
+ `vendorid` — уникальный идентификатор вендора. Тип данных: _bigint_.
+ `payment_amount` — сумма платежа пользователя. Тип данных: _numeric(14, 2)_.
+ `shipping_plan_datetime` — плановая дата доставки. Тип данных: _timestamp_.
+ `transfer_type_id` — внешний ключ: `shipping_info.transfer_type_id` => `shipping_transfer.transfer_type_id`. Тип данных: _integer_.
+ `shipping_country_id` — внешний ключ: `shipping_info.shipping_country_id` => `shipping_country_rates.shipping_country_id`. Тип данных: _integer_.
+ `agreementid` — внешний ключ: `shipping_info.agreementid` => `shipping_agreement.agreementid`. Тип данных: _bigint_.

5. Таблица `public.shipping_status`, содержащая итоговое состояние доставки для каждого уникального `shippingid`:
+ `shippingid` — уникальный идентификатор доставки. Тип данных: _bigint_.
+ `status` — максимальный `shipping.status` по максимальному времени лога `state_datetime`. Тип данных: _text_.
+ `state` — максимальный `shipping.state` по максимальному времени лога `state_datetime`. Тип данных: _text_.
+ `shipping_start_fact_datetime` — время `shipping.state_datetime`, когда `state` заказа перешёл в состояние 'received'. Тип данных: _timestamp_.
