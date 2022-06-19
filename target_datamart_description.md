# Описание целевой аналитической витрины

## Структура представления public.shipping_datamart

+ `shippingid` — уникальный идентификатор доставки. Тип данных: _bigint_.
+ `vendorid` — уникальный идентификатор вендора. Тип данных: _bigint_.
+ `transfer_type` — тип доставки из таблицы `shipping_transfer`. Тип данных: _text_.
+ `full_day_at_shipping` — количество полных дней, в течение которых длилась доставка. Высчитывается как: (`shipping_end_fact_datetime` - `shipping_start_fact_datetime`). Тип данных: _integer_.
+ `is_delay` — статус, показывающий просрочена ли доставка. Высчитывается как: (`shipping_end_fact_datetime` > `shipping_plan_datetime`) => true, иначе => false. Тип данных: _bool_.
+ `is_shipping_finish` — статус, показывающий, что доставка завершена. Если финальный `status` = 'finished' => true, иначе => false. Тип данных: _bool_.
+ `delay_day_at_shipping` — количество дней, на которые была просрочена доставка. Высчитывается как: если (`shipping_end_fact_datetime` > `shipping_end_plan_datetime`) => (`shipping_end_fact_datetime` - `shipping_plan_datetime`), иначе => 0. Тип данных: _integer_.
+ `payment_amount` — сумма платежа пользователя. Тип данных: _numeric(14, 2)_.
+ `vat` — итоговый налог на доставку. Высчитывается как: (`payment_amount` * (`shipping_country_base_rate` + `agreement_rate` + `shipping_transfer_rate`)). Тип данных: _numeric_.
+ `profit` — итоговый доход компании от доставки. Высчитывается как: (`payment_amount` * `agreement_commission`). Тип данных: _numeric_.
