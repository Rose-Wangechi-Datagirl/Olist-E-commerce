---exploring the dataset from the tables
select top 5 *
from [Olist project]..olist_customers_dataset


select top 5 *
from [Olist project]..olist_geolocation_dataset$

select top 5 *
from [Olist project]..olist_order_items_dataset

select top 5 *
from [Olist project]..olist_order_payments_dataset

select  *
from [Olist project]..olist_order_reviews_dataset

select top 5 *
from [Olist project]..olist_orders_dataset

select top 5 *
from [Olist project]..olist_products_dataset

select top 5 *
from [Olist project]..olist_sellers_dataset

select top 5 *
from [Olist project]..product_category_name_translation

--cleaning data from each table

--cleaning the Customer dataset table
select *
from [Olist project]..olist_customers_dataset

--capitalise the customer_city column
Select customer_city = UPPER(SUBSTRING(customer_city, 1, 1)) + LOWER(SUBSTRING(customer_city, 2, LEN(customer_city)))
from [Olist project]..olist_customers_dataset

Update [Olist project]..olist_customers_dataset
Set customer_city = UPPER(SUBSTRING(customer_city, 1, 1)) + LOWER(SUBSTRING(customer_city, 2, LEN(customer_city)))

--Changing the customer_state from short name to long name
Update [Olist project]..olist_customers_dataset
Set customer_state = 
CASE customer_state
    WHEN 'AC' THEN 'Acre'
    WHEN 'AL' THEN 'Alagoas'
    WHEN 'AP' THEN 'Amapa'
    WHEN 'AM' THEN 'Amazonas'
    WHEN 'BA' THEN 'Bahia'
    WHEN 'CE' THEN 'Ceara'
    WHEN 'DF' THEN 'Distrito Federal'
    WHEN 'ES' THEN 'Espirito Santo'
    WHEN 'GO' THEN 'Goias'
    WHEN 'MA' THEN 'Maranhao'
    WHEN 'MT' THEN 'Mato Grosso'
    WHEN 'MS' THEN 'Mato Grosso do Sul'
    WHEN 'MG' THEN 'Minas Gerais'
    WHEN 'PA' THEN 'Para'
    WHEN 'PB' THEN 'Paraiba'
    WHEN 'PR' THEN 'Parana'
    WHEN 'PE' THEN 'Pernambuco'
    WHEN 'PI' THEN 'Piaui'
    WHEN 'RJ' THEN 'Rio de Janeiro'
    WHEN 'RN' THEN 'Rio Grande do Norte'
    WHEN 'RS' THEN 'Rio Grande do Sul'
    WHEN 'RO' THEN 'Rondonia'
    WHEN 'RR' THEN 'Roraima'
    WHEN 'SC' THEN 'Santa Catarina'
    WHEN 'SP' THEN 'Sao Paulo'
    WHEN 'SE' THEN 'Sergipe'
    WHEN 'TO' THEN 'Tocantins'
END;

---cleaning Geolocation table
Select *
from [Olist project]..olist_geolocation_dataset$

---cleaning the geolocation_city column for uniformity
---there are rows with as poá instead of poa 

Select geolocation_city = TRANSLATE(geolocation_city, 'áãçéíóúôâêõ', 'aaceiouoaeo')
from [Olist project]..olist_geolocation_dataset$ 

update [Olist project]..olist_geolocation_dataset$
Set geolocation_city = TRANSLATE(geolocation_city, 'áãçéíóúôâêõ', 'aaceiouoaeo')

--removing the ' in some rows

update [Olist project]..olist_geolocation_dataset$
SET geolocation_city = REPLACE(geolocation_city, '''', '')

--removing unwanted charcaters ... in the begginning of the geolocation city

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = SUBSTRING(geolocation_city, 4, LEN(geolocation_city))
WHERE LEFT(geolocation_city, 3) = '...'

--removing unwanted character * in the begginning of the geolocation city

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = SUBSTRING(geolocation_city, 2, LEN(geolocation_city))
WHERE LEFT(geolocation_city, 1) = '*'

--removing unwanted character 4o in the begginning of the geolocation city

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = STUFF(geolocation_city, 1, 4, '')
WHERE LEFT(geolocation_city, 4) = '4o. '

--removing unwanted character z-3 at the end of of the geolocation city

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = LEFT(geolocation_city, LEN(geolocation_city) - 3)
WHERE geolocation_city LIKE '%z-3'

--removing other unwanted characters

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = REPLACE(REPLACE(geolocation_city, '%26apos%3B', ''''), '%26', '&')
WHERE geolocation_city LIKE '%sao joao do pau d%'

--removing unwanted spaces

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = REPLACE(geolocation_city, ' ', '')
WHERE geolocation_city LIKE '%d alho%'

--capitalise the first letter of the geolocation_city column

UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_city = UPPER(SUBSTRING(geolocation_city, 1, 1)) + LOWER(SUBSTRING(geolocation_city, 2, 
                       LEN(geolocation_city)))

--changing the geolocation state from short name to long name
UPDATE [Olist project]..olist_geolocation_dataset$
SET geolocation_state = 
CASE geolocation_state
    WHEN 'AC' THEN 'Acre'
    WHEN 'AL' THEN 'Alagoas'
    WHEN 'AP' THEN 'Amapa'
    WHEN 'AM' THEN 'Amazonas'
    WHEN 'BA' THEN 'Bahia'
    WHEN 'CE' THEN 'Ceara'
    WHEN 'DF' THEN 'Distrito Federal'
    WHEN 'ES' THEN 'Espirito Santo'
    WHEN 'GO' THEN 'Goias'
    WHEN 'MA' THEN 'Maranhao'
    WHEN 'MT' THEN 'Mato Grosso'
    WHEN 'MS' THEN 'Mato Grosso do Sul'
    WHEN 'MG' THEN 'Minas Gerais'
    WHEN 'PA' THEN 'Para'
    WHEN 'PB' THEN 'Paraiba'
    WHEN 'PR' THEN 'Parana'
    WHEN 'PE' THEN 'Pernambuco'
    WHEN 'PI' THEN 'Piaui'
    WHEN 'RJ' THEN 'Rio de Janeiro'
    WHEN 'RN' THEN 'Rio Grande do Norte'
    WHEN 'RS' THEN 'Rio Grande do Sul'
    WHEN 'RO' THEN 'Rondonia'
    WHEN 'RR' THEN 'Roraima'
    WHEN 'SC' THEN 'Santa Catarina'
    WHEN 'SP' THEN 'Sao Paulo'
    WHEN 'SE' THEN 'Sergipe'
    WHEN 'TO' THEN 'Tocantins'
END

select *
from [Olist project]..olist_geolocation_dataset$

--cleaning the order item dataset table
Select *
from [Olist project]..olist_order_items_dataset
--where order_id = '11ff5f9ab62000ad8044352a96ad4ebf'

-- Checking and Removing duplicates from the table

SELECT order_id, COUNT(order_id) as count
FROM [Olist project]..olist_order_items_dataset
GROUP BY order_id
HAVING COUNT(order_id) > 1;

-- using CTE to delete duplicates

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY (SELECT 0)) AS RN
    FROM [Olist project]..olist_order_items_dataset
)
DELETE FROM CTE 
WHERE RN>1 



--splitting the shipping_limit_date column into date and time 
--add the new columns date and time to the table

ALTER TABLE [Olist project]..olist_order_items_dataset
ADD shipping_date DATE

ALTER TABLE [Olist project]..olist_order_items_dataset
ADD shipping_time TIME

--populating the new date and time columns

UPDATE [Olist project]..olist_order_items_dataset
SET shipping_date = CONVERT(DATE, shipping_limit_date),
    shipping_time = CAST(FORMAT(shipping_limit_date, 'hh:mm:ss') AS TIME)

--droppping the previous column

ALTER TABLE [Olist project]..olist_order_items_dataset DROP CONSTRAINT PK_olist_order_items_dataset

ALTER TABLE [Olist project]..olist_order_items_dataset
DROP COLUMN shipping_limit_date 

--standardising the price and feright_value to 2 decimal places

UPDATE [Olist project]..olist_order_items_dataset
SET price = ROUND (price, 2)

UPDATE [Olist project]..olist_order_items_dataset
SET freight_value = ROUND (freight_value, 2)


--cleaning the order payment table

Select *
from [Olist project]..olist_order_payments_dataset


--checking and removing duplicates

SELECT order_id, COUNT(order_id) as count
FROM [Olist project]..olist_order_payments_dataset
GROUP BY order_id
HAVING COUNT(order_id) > 1;

--using CTE to delete duplicates

WITH CTE AS(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY order_id
	ORDER BY (SELECT 0)) AS RN
	FROM [Olist project]..olist_order_payments_dataset
)

DELETE FROM CTE 
WHERE RN>1


--standardising the payment_value to 2 decimal places

UPDATE [Olist project]..olist_order_payments_dataset
SET payment_value = ROUND (payment_value,2)


--cleaning the olist orders dataset table

select *
from [Olist project]..olist_orders_dataset

--splitting all the columns with timestamps to seperate date and time

ALTER TABLE [Olist project]..olist_orders_dataset ADD order_purchase_date DATE
ALTER TABLE [Olist project]..olist_orders_dataset ADD order_purchase_time TIME

ALTER TABLE [Olist project]..olist_orders_dataset ADD order_approved_date DATE
ALTER TABLE [Olist project]..olist_orders_dataset ADD order_approved_time TIME

ALTER TABLE [Olist project]..olist_orders_dataset ADD order_delivered_tocarrier_date DATE
ALTER TABLE [Olist project]..olist_orders_dataset ADD order_delivered_tocarrier_time TIME

ALTER TABLE [Olist project]..olist_orders_dataset ADD order_delivered_tocustomer_date DATE
ALTER TABLE [Olist project]..olist_orders_dataset ADD order_delivered_tocustomer_time TIME

ALTER TABLE [Olist project]..olist_orders_dataset ADD order_estimated_delivery_dateII DATE

--populising the new created columns
--order purchase date and time

UPDATE [Olist project]..olist_orders_dataset
SET order_purchase_date = CONVERT(DATE, order_purchase_timestamp),
    order_purchase_time = CAST(FORMAT(order_purchase_timestamp, 'hh:mm:ss') AS TIME)

--order approved at date and time

UPDATE [Olist project]..olist_orders_dataset
SET order_approved_date = CONVERT (DATE, order_approved_at),
    order_approved_time = CAST(FORMAT(order_approved_at, 'hh:mm:ss') AS TIME)

--order delivered to carrier date and time

UPDATE [Olist project]..olist_orders_dataset
SET order_delivered_tocarrier_date = CONVERT(DATE, order_delivered_carrier_date),
    order_delivered_tocarrier_time = CAST(FORMAT(order_delivered_carrier_date, 'hh:mm:ss') AS TIME)

--order delivered to customer date and time

UPDATE [Olist project]..olist_orders_dataset
SET order_delivered_tocustomer_date = CONVERT(DATE, order_delivered_customer_date),
    order_delivered_tocustomer_time = CAST(FORMAT(order_delivered_customer_date, 'hh:mm:ss') AS TIME)

--order estimated delivery date

UPDATE [Olist project]..olist_orders_dataset
SET order_estimated_delivery_dateII = CONVERT(DATE, order_estimated_delivery_date)


--dropping the old columns

ALTER TABLE [Olist project]..olist_orders_dataset
DROP COLUMN order_purchase_timestamp

ALTER TABLE [Olist project]..olist_orders_dataset
DROP COLUMN order_approved_at

ALTER TABLE [Olist project]..olist_orders_dataset
DROP COLUMN order_delivered_carrier_date

ALTER TABLE [Olist project]..olist_orders_dataset
DROP COLUMN order_delivered_customer_date

ALTER TABLE [Olist project]..olist_orders_dataset
DROP COLUMN order_estimated_delivery_date

--cleaning the product table 

--changing the product category name from spanish to English

ALTER TABLE [Olist project]..olist_products_dataset
ADD product_category NVARCHAR (50) 

--populating the new column from the product name translation table

UPDATE [Olist project]..olist_products_dataset
SET product_category = t2.English
FROM [Olist project]..olist_products_dataset t1
JOIN [Olist project]..product_category_name_translation t2 ON t1.product_category_name = t2.Spanish

--checking for nulls 
SELECT DISTINCT product_category, product_category_name
FROM [Olist project]..olist_products_dataset 
WHERE product_category IS NULL
GROUP BY product_category, product_category_name

--inserting the english translations in the translation table to remove the null values in the products table

INSERT INTO [Olist project]..product_category_name_translation (Spanish,English)
VALUES ('pc_gamer', 'gaming_pc');

INSERT INTO [Olist project]..product_category_name_translation (Spanish,English)
VALUES ('portateis_cozinha_e_preparadores_de_alimentos', 'portable_kitchen_and_food_preparators');

INSERT INTO [Olist project]..product_category_name_translation (Spanish,English)
VALUES ('N/A', 'N/A')

--confirming the changes

SELECT product_category
FROM [Olist project]..olist_products_dataset 
where product_category like '%portable%'

--dropping the old column
ALTER TABLE [Olist project]..olist_products_dataset 
DROP COLUMN product_category_name


--cleaning the sellers table
 select * 
 from [Olist project]..olist_sellers_dataset

 --capitalising the sellet city town

 UPDATE [Olist project]..olist_sellers_dataset
 SET seller_city = UPPER(SUBSTRING(seller_city, 1, 1)) + LOWER(SUBSTRING(seller_city, 2, LEN(seller_city)))

 --changing seller state form short name to long

 UPDATE [Olist project]..olist_sellers_dataset
 SET seller_state = 
     CASE seller_state 
		WHEN 'AC' THEN 'Acre'
		WHEN 'AL' THEN 'Alagoas'
		WHEN 'AP' THEN 'Amapa'
		WHEN 'AM' THEN 'Amazonas'
		WHEN 'BA' THEN 'Bahia'
		WHEN 'CE' THEN 'Ceara'
		WHEN 'DF' THEN 'Distrito Federal'
		WHEN 'ES' THEN 'Espirito Santo'
		WHEN 'GO' THEN 'Goias'
		WHEN 'MA' THEN 'Maranhao'
		WHEN 'MT' THEN 'Mato Grosso'
		WHEN 'MS' THEN 'Mato Grosso do Sul'
		WHEN 'MG' THEN 'Minas Gerais'
		WHEN 'PA' THEN 'Para'
		WHEN 'PB' THEN 'Paraiba'
		WHEN 'PR' THEN 'Parana'
		WHEN 'PE' THEN 'Pernambuco'
		WHEN 'PI' THEN 'Piaui'
		WHEN 'RJ' THEN 'Rio de Janeiro'
		WHEN 'RN' THEN 'Rio Grande do Norte'
		WHEN 'RS' THEN 'Rio Grande do Sul'
		WHEN 'RO' THEN 'Rondonia'
		WHEN 'RR' THEN 'Roraima'
		WHEN 'SC' THEN 'Santa Catarina'
		WHEN 'SP' THEN 'Sao Paulo'
		WHEN 'SE' THEN 'Sergipe'
		WHEN 'TO' THEN 'Tocantins'
END;

 --cleaning the order reviews dataset

 select  *
from [Olist project]..olist_order_reviews_dataset

--checking and removing duplicates

SELECT review_id, count(*)
from [Olist project]..olist_order_reviews_dataset
group by review_id
having count(*) >1
---

WITH CTE AS(
SELECT *, ROW_NUMBER() OVER(PARTITION BY review_id 
ORDER BY (SELECT 0)) AS RN
FROM [Olist project]..olist_order_reviews_dataset
)

DELETE FROM CTE 
WHERE RN>1


--Data is now  clean and ready for visualisation telling a story to the stakeholders