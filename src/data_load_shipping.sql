-- Загрузка данных из файла источника shipping.csv в таблицу "shipping" (с помощью скрипта или используя клиент)
COPY
    online_store.public.shipping
FROM
    'data/shipping.csv'
DELIMITER
    ','
CSV HEADER;
