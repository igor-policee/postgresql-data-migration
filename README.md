# Миграция данных и подготовка витрины данных для аналитики

Миграция данных из таблицы лога `public.shipping` в отдельные логические таблицы и последующая сборка витрины для аналитики с целью оптимизации нагрузки на хранилище и предоставления возможности аналитикам отвечать на точечные вопросы об эффективности бизнеса. 

## Существующая модель данных

> [Описание текущей модели данных](inital_datamodel_description.md)

> [SQL для создания таблицы лога и загрузки данных](src/0_shipping.sql)

> [Данные для загрузки в таблицу лога](data/shipping.csv)
 
## Целевая модель данных

> [Описание целевой модели данных](target_datamodel_description.md)

> [Описание целевой аналитической витрины](target_datamart_description.md) 

## Создание новых логических таблиц и миграция

> 1. [SQL для создания и заполнения таблицы `shipping_country_rates`](src/1_shipping_country_rates.sql)

> 2. [SQL для создания и заполнения таблицы `shipping_agreement`](src/2_shipping_agreement.sql)

> 3. [SQL для создания и заполнения таблицы `shipping_transfer`](src/3_shipping_transfer.sql)

> 4. [SQL для создания и заполнения таблицы `shipping_info`](src/4_shipping_info.sql)

> 5. [SQL для создания и заполнения таблицы `shipping_status`](src/5_shipping_status.sql)

## Подготовка витрины для аналитики

> 6. [SQL для создания и заполнения представления `shipping_datamart`](src/6_shipping_datamart.sql)
