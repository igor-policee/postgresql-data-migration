# Требования к целевым логическим таблицам и миграции данных

> ![Схема целевой модели данных](data/target_datamodel_er.png)

1. Справочник `shipping_country_rates`, содержащий уникальные пары соответствующих полей таблицы `shipping`:
+ `shipping_country_id` — первичный ключ, _serial_;
+ `shipping_country` — _text_;
+ `shipping_country_base_rate` — _text_.

2. Справочник `shipping_agreement`, содержащий данные поля `vendor_agreement_description` таблицы `shipping`, разделенные знаком `:`:
+ `agreementid` — первичный ключ, _bigint_;
+ `agreement_number` — _text_;
+ `agreement_rate` — _numeric(14, 2)_;
+ `agreement_commission` — _numeric(14, 2)_.

3. Справочник `shipping_transfer`, содержащий данные поля `shipping_transfer_description` таблицы `shipping`, разделенные знаком `:`:
+ `transfer_type_id` — первичный ключ, _serial_;
+ `transfer_type` — _text_;
+ `transfer_model` — _text_;
+ `shipping_transfer_rate` — _numeric(14, 3)_.

4. Таблица `shipping_info`, содержащая уникальные идентификаторы доставки `shippingid` и связанная с созданными справочниками `shipping_country_rates`, `shipping_agreement`, `shipping_transfer` и константной информацией о доставке `shipping_plan_datetime`, `payment_amount`, `vendorid`:
+ `shippingid` — _bigint_;
+ `vendorid` — _bigint_;
+ `payment_amount` — _numeric(14, 2)_;
+ `shipping_plan_datetime` — _timestamp_;
+ `transfer_type_id` — внешний ключ: `shipping_info (transfer_type_id)` => `shipping_transfer (transfer_type_id)`, _integer_;
+ `shipping_country_id` — внешний ключ: `shipping_info (shipping_country_id)` => `shipping_country_rates (shipping_country_id)`, _integer_;
+ `agreementid` — внешний ключ: `shipping_info (agreementid)` => `shipping_agreement (agreementid)`, _bigint_.

5. Таблица `shipping_status`, содержащая итоговое состояние доставки для каждого уникального `shippingid`:
+ `shippingid` — уникальный идентификатор доставки, _bigint_;
+ `status` — максимальный `shipping.status` по максимальному времени лога `state_datetime`, _text_;
+ `state` — максимальный `shipping.state` по максимальному времени лога `state_datetime`, _text_;
+ `shipping_start_fact_datetime` — время `shipping.state_datetime`, когда `state` заказа перешёл в состояние 'received', _timestamp_.
