create database dw_groupA_hr;

use dw_groupa_hr;

CREATE TABLE a_dim_category (
    category_id INT NOT NULL COMMENT 'category id num',
    c_name      VARCHAR(30) NOT NULL COMMENT 'category name'
);

ALTER TABLE a_dim_category ADD CONSTRAINT a_dim_category_pk PRIMARY KEY ( category_id );
 
CREATE TABLE a_dim_customer (
    customer_id VARCHAR(30) NOT NULL COMMENT 'CUSTOMER ID NUM',
    c_fname     VARCHAR(30) NOT NULL COMMENT 'CUSTOMER FIRST NAME',
    c_lname     VARCHAR(30) COMMENT 'CUSTOMER_LAST NAME',
    c_city      VARCHAR(30) NOT NULL COMMENT 'CUSTOMER CITY',
    c_state     VARCHAR(40) NOT NULL COMMENT 'customer state',
    c_country   VARCHAR(30) NOT NULL COMMENT 'customer country',
    c_pincode   VARCHAR(5) COMMENT 'customer pincode',
    c_segment   VARCHAR(30) NOT NULL COMMENT 'customer segment'
);

ALTER TABLE a_dim_customer ADD CONSTRAINT a_dim_customer_pk PRIMARY KEY ( customer_id );
 
CREATE TABLE a_dim_market (
    market_id INT NOT NULL COMMENT 'Market ID NUMBER',
    m_name    VARCHAR(30) NOT NULL COMMENT 'MARKET NAME'
);

ALTER TABLE a_dim_market ADD CONSTRAINT a_dim_market_pk PRIMARY KEY ( market_id );
 

CREATE TABLE a_dim_order (
    order_seq   INT NOT NULL COMMENT 'order sequence',
    o_date      DATETIME NOT NULL COMMENT 'order date',
    o_priority  VARCHAR(20) NOT NULL COMMENT 'order priority',
    o_ship_mode VARCHAR(20) NOT NULL COMMENT 'order ship mode',
    o_ship_date DATETIME NOT NULL COMMENT 'order shipment date',
    order_id    VARCHAR(30) NOT NULL COMMENT 'order id'
);

ALTER TABLE a_dim_order ADD CONSTRAINT a_dim_order_pk PRIMARY KEY ( order_seq );
 
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE a_dim_product (
    product_id VARCHAR(11) NOT NULL COMMENT 'product id number',
    p_name     VARCHAR(300) NOT NULL COMMENT 'product name'
);
 ALTER TABLE a_dim_product ADD CONSTRAINT a_dim_product_pk PRIMARY KEY ( product_id );
 

CREATE TABLE a_dim_region (
    region_id INT NOT NULL COMMENT 'REGION ID',
    r_name    VARCHAR(30) NOT NULL COMMENT 'REGION NAME'
);

ALTER TABLE a_dim_region ADD CONSTRAINT a_dim_region_pk PRIMARY KEY ( region_id );
 

CREATE TABLE a_dim_sub_category (
    subcategory_id INT NOT NULL COMMENT 'subcategory id',
    s_name         VARCHAR(30) NOT NULL COMMENT 'subcategory name'
);
 
 ALTER TABLE a_dim_sub_category ADD CONSTRAINT a_dim_sub_category_pk PRIMARY KEY ( subcategory_id );
 
 CREATE TABLE a_fact_order_product (
    item_seq       INT NOT NULL COMMENT 'item sequence',
    quantity       SMALLINT NOT NULL COMMENT 'quantity number',
    sales_price    VARCHAR(15) NOT NULL COMMENT 'sales price',
    discount       DECIMAL(3, 2) COMMENT 'discount',
    shipment_cost  VARCHAR(15) NOT NULL COMMENT 'shipment cost',
    product_id     VARCHAR(11) NOT NULL COMMENT 'product id number',
    region_id      INT NOT NULL COMMENT 'region id number',
    customer_id    VARCHAR(30) NOT NULL COMMENT 'customer id number',
    market_id      INT NOT NULL COMMENT 'market id  number',
    order_seq      INT NOT NULL COMMENT 'order sequence',
    subcategory_id INT NOT NULL COMMENT 'subcategory id',
    category_id    INT NOT NULL COMMENT 'category id number',
    date_key       INTEGER NOT NULL COMMENT 'date key'
);
Alter table A_fact_order_product 
add column order_date DATE;

ALTER TABLE a_fact_order_product ADD CONSTRAINT a_fact_order_product_pk PRIMARY KEY ( item_seq );

CREATE TABLE dim_date (
    date_key             INTEGER NOT NULL COMMENT 'date key',
    full_date            DATETIME COMMENT 'full date number',
    date_name            CHAR(11) COMMENT 'date name',
    date_name_us         CHAR(11) COMMENT 'date name US',
    date_name_eu         CHAR(11) COMMENT 'date name eu',
    day_of_week          DECIMAL(38) COMMENT 'day of the week',
    day_name_of_week     CHAR(11) COMMENT 'day name of the week',
    day_of_month         DECIMAL(38) COMMENT 'day of the month',
    day_of_year          DATETIME COMMENT 'day  of the year',
    weekday_weekend      CHAR(10) COMMENT 'weekday weekend',
    week_of_year         DECIMAL(38) COMMENT 'week of the year',
    month_name           CHAR(10) COMMENT 'month  name',
    month_of_year        DECIMAL(38) COMMENT 'month  of the year',
    is_last_day_of_month CHAR(1) COMMENT 'last day of the month',
    calendar_quarter     DECIMAL(38) COMMENT 'calendar quarter',
    calendar_year        DECIMAL(38) COMMENT 'calendar year',
    calendar_year_month  CHAR(10) COMMENT 'calendar year month',
    calendar_year_qtr    CHAR(10) COMMENT 'calendar year quarter',
    fiscal_month_of_year DECIMAL(38) COMMENT 'fiscal month of the year',
    fiscal_quarter       DECIMAL(38) COMMENT 'fiscal quarter',
    fiscal_year          INTEGER COMMENT 'fiscal year',
    fiscal_year_month    CHAR(10) COMMENT 'fiscal year month',
    fiscal_year_qtr      CHAR(10) COMMENT 'fiscal year quarter'
);

ALTER TABLE dim_date ADD CONSTRAINT dim_date_pk PRIMARY KEY ( date_key );

ALTER TABLE A_DIM_MARKET MODIFY MARKET_ID INT NOT NULL AUTO_INCREMENT;
ALTER TABLE A_DIM_REGION MODIFY REGION_ID INT NOT NULL AUTO_INCREMENT;
ALTER TABLE A_DIM_CATEGORY MODIFY CATEGORY_ID INT NOT NULL AUTO_INCREMENT;
ALTER TABLE A_DIM_SUB_CATEGORY MODIFY SUBCATEGORY_ID INT NOT NULL AUTO_INCREMENT;
ALTER TABLE A_DIM_ORDER MODIFY ORDER_SEQ INT NOT NULL AUTO_INCREMENT;
ALTER TABLE A_FACT_ORDER_PRODUCT MODIFY ITEM_SEQ INT NOT NULL AUTO_INCREMENT;

ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_category_fk FOREIGN KEY ( category_id )
        REFERENCES a_dim_category ( category_id );
        
ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_customer_fk FOREIGN KEY ( customer_id )
        REFERENCES a_dim_customer ( customer_id );
 
 ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_dim_date_fk FOREIGN KEY ( date_key )
        REFERENCES dim_date ( date_key );
 
ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_market_fk FOREIGN KEY ( market_id )
        REFERENCES a_dim_market ( market_id );
 
ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_order_fk FOREIGN KEY ( order_seq )
        REFERENCES a_dim_order ( order_seq );
 
ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_product_fk FOREIGN KEY ( product_id )
        REFERENCES a_dim_product ( product_id );
 
ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_region_fk FOREIGN KEY ( region_id )
        REFERENCES a_dim_region ( region_id );
 
ALTER TABLE a_fact_order_product
    ADD CONSTRAINT a_fact_sub_category_fk FOREIGN KEY ( subcategory_id )
        REFERENCES a_dim_sub_category ( subcategory_id );

 ALTER TABLE  A_DIM_market  ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_DIM_category ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_DIM_customer ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_DIM_order ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_DIM_product ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_DIM_region ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_DIM_sub_category ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE A_FACT_order_product ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

DELIMITER $$
CREATE TRIGGER `TI_MARKET_default_date` BEFORE INSERT ON `a_DIM_market` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_MARKET_default_date` BEFORE UPDATE ON `a_DIM_market` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter;


  -- ALTER TABLE  region  ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

DELIMITER $$
CREATE TRIGGER `TI_REGIONS_default_date` BEFORE INSERT ON `A_DIM_region` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_REGIONS_default_date` BEFORE UPDATE ON `A_DIM_region` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;

-- TBL_LAST_DATE and Triggers on  category  table


DELIMITER $$
CREATE TRIGGER `TI_category_default_date` BEFORE INSERT ON `A_DIM_category` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_category_default_date` BEFORE UPDATE ON `A_DIM_category` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;

-- TBL_LAST_DATE and Triggers on  sub_category  table

ALTER TABLE  sub_category  ADD TBL_LAST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

DELIMITER $$
CREATE TRIGGER `TI_sub_category_default_date` BEFORE INSERT ON `A_DIM_sub_category` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_sub_category_default_date` BEFORE UPDATE ON `A_DIM_sub_category` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;

-- TBL_LAST_DATE and Triggers on   customer  table


DELIMITER $$
CREATE TRIGGER `TI_ customer_default_date` BEFORE INSERT ON `A_DIM_customer` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_ customer_default_date` BEFORE UPDATE ON `A_DIM_customer` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;


-- TBL_LAST_DATE and Triggers on `ORDER_PRODUCT`  table

DELIMITER $$
CREATE TRIGGER `TI_ORDER_PRODUCT_default_date` BEFORE INSERT ON `A_FACT_ORDER_PRODUCT` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_ORDER_PRODUCT_default_date` BEFORE UPDATE ON `A_FACT_ORDER_PRODUCT` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;

-- TBL_LAST_DATE and Triggers on `ORDER`  table

DELIMITER $$
CREATE TRIGGER `TI_ORDER_default_date` BEFORE INSERT ON `A_DIM_ORDER` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_ORDER_default_date` BEFORE UPDATE ON `A_DIM_ORDER` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;

-- TBL_LAST_DATE and Triggers on `PRODUCT`  table

DELIMITER $$
CREATE TRIGGER `TI_PRODUCT_default_date` BEFORE INSERT ON `A_DIM_PRODUCT` FOR EACH ROW
if ( isnull(new.tbl_last_date) ) then
 set new.tbl_last_date=current_timestamp();
end if;
$$
delimiter ;

DELIMITER $$
CREATE TRIGGER `TU_PRODUCT_default_date` BEFORE UPDATE ON `A_DIM_PRODUCT` FOR EACH ROW
set NEW.tbl_last_date=current_timestamp();
$$
delimiter ;


set foreign_key_checks = 0;
drop table if exists dim_date;
CREATE TABLE dim_date(
 date_key int NOT NULL,
 full_date date NULL,
 date_name char(11) NOT NULL,
 date_name_us char(11) NOT NULL,
 date_name_eu char(11) NOT NULL,
 day_of_week tinyint NOT NULL,
 day_name_of_week char(10) NOT NULL,
 day_of_month tinyint NOT NULL,
 day_of_year smallint NOT NULL,
 weekday_weekend char(10) NOT NULL,
 week_of_year tinyint NOT NULL,
 month_name char(10) NOT NULL,
 month_of_year tinyint NOT NULL,
 is_last_day_of_month char(1) NOT NULL,
 calendar_quarter tinyint NOT NULL,
 calendar_year smallint NOT NULL,
 calendar_year_month char(10) NOT NULL,
 calendar_year_qtr char(10) NOT NULL,
 fiscal_month_of_year tinyint NOT NULL,
 fiscal_quarter tinyint NOT NULL,
 fiscal_year int NOT NULL,
 fiscal_year_month char(10) NOT NULL,
 fiscal_year_qtr char(10) NOT NULL,
  PRIMARY KEY (`date_key`)
) ;

delimiter //

drop procedure if exists PopulateDateDimension//

CREATE PROCEDURE PopulateDateDimension(BeginDate DATETIME, EndDate DATETIME)
BEGIN

 # =============================================
 # Description: http://arcanecode.com/2009/11/18/populating-a-kimball-date-dimension/
 # =============================================

 # A few notes, this code does nothing to the existing table, no deletes
 # are triggered before hand. Because the DateKey is uniquely indexed,
 # it will simply produce errors if you attempt to insert duplicates.
 # You can however adjust the Begin/End dates and rerun to safely add
 # new dates to the table every year.
 #
 # If the begin date is after the end date, no errors occur but nothing
 # happens as the while loop never executes.

 # Holds a flag so we can determine if the date is the last day of month
 DECLARE LastDayOfMon CHAR(1);

 # Number of months to add to the date to get the current Fiscal date
 DECLARE FiscalYearMonthsOffset INT;

 # These two counters are used in our loop.
 DECLARE DateCounter DATETIME;    #Current date in loop
 DECLARE FiscalCounter DATETIME;  #Fiscal Year Date in loop

 # Set this to the number of months to add to the current date to get
 # the beginning of the Fiscal year. For example, if the Fiscal year
 # begins July 1, put a 6 there.
 # Negative values are also allowed, thus if your 2010 Fiscal year
 # begins in July of 2009, put a -6.
 SET FiscalYearMonthsOffset = 6;

 # Start the counter at the begin date
 SET DateCounter = BeginDate;

 WHILE DateCounter <= EndDate DO
            # Calculate the current Fiscal date as an offset of
            # the current date in the loop

            SET FiscalCounter = DATE_ADD(DateCounter, INTERVAL FiscalYearMonthsOffset MONTH);

            # Set value for IsLastDayOfMonth
            IF MONTH(DateCounter) = MONTH(DATE_ADD(DateCounter, INTERVAL 1 DAY)) THEN
               SET LastDayOfMon = 'N';
            ELSE
               SET LastDayOfMon = 'Y';
   END IF;

            # add a record into the date dimension table for this date
            INSERT  INTO dim_date
       (date_key
       ,full_date
       ,date_name
       ,date_name_us
       ,date_name_eu
       ,day_of_week
       ,day_name_of_week
       ,day_of_month
       ,day_of_year
       ,weekday_weekend
       ,week_of_year
       ,month_name
       ,month_of_year
       ,is_last_day_of_month
       ,calendar_quarter
       ,calendar_year
       ,calendar_year_month
       ,calendar_year_qtr
       ,fiscal_month_of_year
       ,fiscal_quarter
       ,fiscal_year
       ,fiscal_year_month
       ,fiscal_year_qtr)
            VALUES  (
                      ( YEAR(DateCounter) * 10000 ) + ( MONTH(DateCounter)
                                                         * 100 )
                      + DAY(DateCounter)  #DateKey
                    , DateCounter # FullDate
                    , CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),'/',DATE_FORMAT(DateCounter,'%m'),'/',DATE_FORMAT(DateCounter,'%d')) #DateName
                    , CONCAT(DATE_FORMAT(DateCounter,'%m'),'/',DATE_FORMAT(DateCounter,'%d'),'/',CAST(YEAR(DateCounter) AS CHAR(4)))#DateNameUS
                    , CONCAT(DATE_FORMAT(DateCounter,'%d'),'/',DATE_FORMAT(DateCounter,'%m'),'/',CAST(YEAR(DateCounter) AS CHAR(4)))#DateNameEU
                    , DAYOFWEEK(DateCounter) #DayOfWeek
                    , DAYNAME(DateCounter) #DayNameOfWeek
                    , DAYOFMONTH(DateCounter) #DayOfMonth
                    , DAYOFYEAR(DateCounter) #DayOfYear
                    , CASE DAYNAME(DateCounter)
                        WHEN 'Saturday' THEN 'Weekend'
                        WHEN 'Sunday' THEN 'Weekend'
                        ELSE 'Weekday'
                      END #WeekdayWeekend
                    , WEEKOFYEAR(DateCounter) #WeekOfYear
                    , MONTHNAME(DateCounter) #MonthName
                    , MONTH(DateCounter) #MonthOfYear
                    , LastDayOfMon #IsLastDayOfMonth
                    , QUARTER(DateCounter) #CalendarQuarter
                    , YEAR(DateCounter) #CalendarYear
                    , CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),'-',DATE_FORMAT(DateCounter,'%m')) #CalendarYearMonth
                    , CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),'Q',QUARTER(DateCounter)) #CalendarYearQtr
                    , MONTH(FiscalCounter) #[FiscalMonthOfYear]
                    , QUARTER(FiscalCounter) #[FiscalQuarter]
                    , YEAR(FiscalCounter) #[FiscalYear]
                    , CONCAT(CAST(YEAR(FiscalCounter) AS CHAR(4)),'-',DATE_FORMAT(FiscalCounter,'%m')) #[FiscalYearMonth]
                    , CONCAT(CAST(YEAR(FiscalCounter) AS CHAR(4)),'Q',QUARTER(FiscalCounter)) #[FiscalYearQtr]
                    );

            # Increment the date counter for next pass thru the loop
            SET DateCounter = DATE_ADD(DateCounter, INTERVAL 1 DAY);
      END WHILE;


END//

alter table A_fact_order_product add date_key int;

SET SQL_SAFE_UPDATES = 0;
update A_fact_order_product
set date_key=DATE_FORMAT(order_date,'%Y%m%d');



 ALTER TABLE A_fact_order_product ADD INDEX index_o_date_yyyymmdd((DATE_FORMAT(order_date,'%Y%m%d')));
index_o_date_yyyymmdd
select item_seq,order_date,e.date_key, d.date_key from a_fact_order_product e join dim_date d on e.date_key = d.date_key;

-- adding FOREIGN KEY date_key REFERENCING dim_date(date_key)

alter table a_fact_order_product add constraint fk_date_key foreign key (date_key)  references dim_date(date_key);


END//

SHOW GRANTS FOR 'root'@'localhost';

SELECT host,user,Grant_priv,Super_priv FROM mysql.user;
SET SQL_SAFE_UPDATES = 0;

UPDATE mysql.user SET Grant_priv='Y', Super_priv='Y'
WHERE User='root';
FLUSH PRIVILEGES;

GRANT ALL ON *.* TO 'root'@'localhost';

INSERT INTO dw_groupa_hr.A_DIM_region (REGION_ID, R_NAME)
SELECT * FROM
 (SELECT REGION_ID, R_NAME FROM groupa_project.groupa_region) AS dt
ON DUPLICATE KEY UPDATE R_name =dt.r_NAME;

INSERT INTO A_DIM_category (CATEGORY_ID, C_NAME)
SELECT * FROM
 (SELECT CATEGORY_ID, C_NAME FROM groupa_project.groupa_category) AS dt
ON DUPLICATE KEY UPDATE C_NAME=dt.C_NAME;
 
 
 

INSERT INTO dw_groupa_hr.A_DIM_customer (CUSTOMER_ID,C_FNAME,C_LNAME,C_CITY,C_STATE,C_COUNTRY,C_PINCODE,C_SEGMENT)
SELECT * FROM
 (SELECT CUSTOMER_ID,C_FNAME,C_LNAME,C_CITY,C_STATE,C_COUNTRY,C_PINCODE,C_SEGMENT 
 FROM groupa_project.groupa_customer) AS dt
ON DUPLICATE KEY UPDATE C_FNAME=dt.C_FNAME, C_LNAME=dt.C_LNAME, 
C_CITY=dt.C_CITY, C_STATE=dt.C_STATE, C_COUNTRY=dt.C_COUNTRY,C_PINCODE=dt.C_PINCODE,C_SEGMENT = dt.C_SEGMENT ;
 
 

 
 
INSERT INTO dw_groupa_hr.A_DIM_market (MARKET_ID,M_NAME)
SELECT * FROM
 (SELECT MARKET_ID,M_NAME FROM groupa_project.groupa_market) AS dt
ON DUPLICATE KEY UPDATE M_NAME=dt.M_NAME;


INSERT INTO dw_groupa_hr.A_DIM_ORDER (ORDER_SEQ,O_DATE,O_PRIORITY,O_SHIP_MODE,O_SHIP_DATE,ORDER_ID)
SELECT * FROM
 (SELECT ORDER_SEQ,O_DATE,O_PRIORITY,O_SHIP_MODE,O_SHIP_DATE,ORDER_ID FROM groupa_project.groupa_order ) AS dt
ON DUPLICATE KEY UPDATE ORDER_SEQ=dt.ORDER_SEQ, O_DATE=dt.O_DATE,O_PRIORITY=dt.O_PRIORITY, 
O_SHIP_MODE=dt.O_SHIP_MODE,O_SHIP_DATE=dt.O_SHIP_DATE,ORDER_ID=dt.ORDER_ID;

INSERT INTO dw_groupa_hr.A_DIM_PRODUCT (PRODUCT_ID,P_NAME)
SELECT * FROM (SELECT PRODUCT_ID,P_NAME FROM groupa_project.groupa_product) AS dt
ON DUPLICATE KEY UPDATE P_NAME = dt.P_NAME;


INSERT INTO dw_groupa_hr.A_DIM_SUB_CATEGORY (SUBCATEGORY_ID,S_NAME)
SELECT * FROM (SELECT SUBCATEGORY_ID,S_NAME FROM groupa_project.groupa_sub_category) AS dt
ON DUPLICATE KEY UPDATE S_NAME = dt.S_NAME;

DELETE from a_fact_order_product;
Select *
FROM a_fact_order_product;
INSERT INTO a_fact_order_PRODUCT(item_SEQ,QUANTITY,sales_price,discount,shipment_cost,product_id,region_id,
customer_id,market_id,order_seq,subcategory_id,category_id,date_key)
SELECT * 
FROM
(SELECT e.item_SEQ,e.QUANTITY,e.sales_price,e.discount,e.shipment_cost,p.product_id,r.region_id,c.customer_ID,
m.market_ID,o.order_seq,s.subcategory_id,t.category_id,
FROM   groupa_project.groupa_order_product e 
JOIN groupa_project.groupa_order o ON e.order_seq = o.order_seq
JOIN groupa_project.groupa_product p  ON e.product_ID=p.product_id
JOIN groupa_project.groupa_sub_category s  on p.subcategory_id = s.subcategory_id
JOIN groupa_project.groupa_category t on s.category_id = t.category_id
JOIN groupa_project.groupa_customer c  ON o.customer_ID= c.CUSTOMER_ID
JOIN groupa_project.groupa_region r  ON c.region_ID=r.region_ID
JOIN groupa_project.groupa_market m  ON r.market_id = m.market_id
) as dt
ON DUPLICATE KEY UPDATE QUANTITY=dt.QUANTITY, sales_price = dt.sales_price,
discount=dt.discount,shipment_cost = dt.shipment_cost,product_id=dt.product_id,subcategory_id = dt.subcategory_id,
product_id=dt.product_id,region_id=dt.region_id, 
customer_id=dt.customer_id,market_id=dt.market_id, order_seq=dt.order_seq,
category_id=dt.category_id;

update a_fact_order_product
set quantity=replace(quantity,'$','') ;


,DATE_FORMAT(o.o_date,'%Y%m%d') 

INSERT INTO A_DIM_region (REGION_ID, R_NAME)
SELECT * FROM
  (SELECT REGION_ID, R_NAME FROM dw_groupa_hr.A_DIM_region where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE R_NAME=dt.R_NAME;


==== making some data changes for insert/update in OLTP schema

UPDATE A_DIM_MARKET
SET m_name = 'USA'
WHERE MARKET_ID = 1;

commit;

UPDATE A_DIM_category
SET c_name = 'computing equipment'
WHERE CATEGORY_ID = 1;

commit;

==== INCREMENTAL ETL
INSERT INTO dw_groupa_hr.A_DIM_region (REGION_ID, R_NAME)
SELECT * FROM
 (SELECT REGION_ID, R_NAME FROM groupa_project.groupa_region where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE R_name =dt.r_NAME;

INSERT INTO A_DIM_category (CATEGORY_ID, C_NAME)
SELECT * FROM
 (SELECT CATEGORY_ID, C_NAME FROM groupa_project.groupa_category where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE C_NAME=dt.C_NAME;
 
 
 

INSERT INTO dw_groupa_hr.A_DIM_customer (CUSTOMER_ID,C_FNAME,C_LNAME,C_CITY,C_STATE,C_COUNTRY,C_PINCODE,C_SEGMENT)
SELECT * FROM
 (SELECT CUSTOMER_ID,C_FNAME,C_LNAME,C_CITY,C_STATE,C_COUNTRY,C_PINCODE,C_SEGMENT 
 FROM groupa_project.groupa_customer where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE C_FNAME=dt.C_FNAME, C_LNAME=dt.C_LNAME, 
C_CITY=dt.C_CITY, C_STATE=dt.C_STATE, C_COUNTRY=dt.C_COUNTRY,C_PINCODE=dt.C_PINCODE,C_SEGMENT = dt.C_SEGMENT ;
 
 

 
 INSERT INTO dw_groupa_hr.A_DIM_market (MARKET_ID,M_NAME)
SELECT * FROM
 (SELECT MARKET_ID,M_NAME FROM groupa_project.groupa_market where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE M_NAME=dt.M_NAME;


INSERT INTO dw_groupa_hr.A_DIM_ORDER (ORDER_SEQ,O_DATE,O_PRIORITY,O_SHIP_MODE,O_SHIP_DATE,ORDER_ID)
SELECT * FROM
 (SELECT ORDER_SEQ,O_DATE,O_PRIORITY,O_SHIP_MODE,O_SHIP_DATE,ORDER_ID FROM groupa_project.groupa_order 
 where tbl_last_date>date_sub(curdate(),interval 1 day) ) AS dt
ON DUPLICATE KEY UPDATE ORDER_SEQ=dt.ORDER_SEQ, O_DATE=dt.O_DATE,O_PRIORITY=dt.O_PRIORITY, 
O_SHIP_MODE=dt.O_SHIP_MODE,O_SHIP_DATE=dt.O_SHIP_DATE,ORDER_ID=dt.ORDER_ID;

INSERT INTO dw_groupa_hr.A_DIM_PRODUCT (PRODUCT_ID,P_NAME)
SELECT * FROM (SELECT PRODUCT_ID,P_NAME FROM groupa_project.groupa_product
where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE P_NAME = dt.P_NAME;


INSERT INTO dw_groupa_hr.A_DIM_SUB_CATEGORY (SUBCATEGORY_ID,S_NAME)
SELECT * FROM (SELECT SUBCATEGORY_ID,S_NAME FROM groupa_project.groupa_sub_category
where tbl_last_date>date_sub(curdate(),interval 1 day)) AS dt
ON DUPLICATE KEY UPDATE S_NAME = dt.S_NAME;



INSERT INTO a_fact_order_PRODUCT(item_SEQ,QUANTITY,sales_price,discount,shipment_cost,product_id,region_id,
customer_id,market_id,order_seq,subcategory_id,category_id)
SELECT * 
FROM
(SELECT e.item_SEQ,e.QUANTITY,e.sales_price,e.discount,e.shipment_cost,p.product_id,r.region_id,c.customer_ID,
m.market_ID,o.order_seq,s.subcategory_id,t.category_id
FROM   groupa_project.groupa_order_product e 
JOIN groupa_project.groupa_order o ON e.order_seq = o.order_seq
JOIN groupa_project.groupa_product p  ON e.product_ID=p.product_id
JOIN groupa_project.groupa_sub_category s  on p.subcategory_id = s.subcategory_id
JOIN groupa_project.groupa_category t on s.category_id = t.category_id
JOIN groupa_project.groupa_customer c  ON o.customer_ID= c.CUSTOMER_ID
JOIN groupa_project.groupa_region r  ON c.region_ID=r.region_ID
JOIN groupa_project.groupa_market m  ON r.market_id = m.market_id
where e.tbl_last_date>date_sub(curdate(),interval 1 day)
) as dt
ON DUPLICATE KEY UPDATE QUANTITY=dt.QUANTITY, sales_price = dt.sales_price,
discount=dt.discount,shipment_cost = dt.shipment_cost,product_id=dt.product_id,subcategory_id = dt.subcategory_id,
product_id=dt.product_id,region_id=dt.region_id, 
customer_id=dt.customer_id,market_id=dt.market_id, order_seq=dt.order_seq,
category_id=dt.category_id;

update a_fact_order_product
set quantity=replace(quantity,'$','') ;

== verifying incremental data changes  
UPDATE A_DIM_MARKET
SET m_name = 'USA'
WHERE MARKET_ID = 1;

SELECT * 
FROM A_DIM_MARKET
WHERE MARKET_ID = 1;

UPDATE A_DIM_category
SET c_name = 'computing equipment'
WHERE CATEGORY_ID = 1;

SELECT *
FROM A_DIM_CATEGORY
WHERE CATEGORY_ID = 1;

