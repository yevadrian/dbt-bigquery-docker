{{ config(materialized='view') }}

with merged as (
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-01`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-02`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-03`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-04`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-05`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-06`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-07`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-08`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-09`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-10`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-11`
    union all
    select * from `lyrical-country-370008.yellow_tripdata.yellow_tripdata_2019-12`
), 

cleaned as (
    select 
        {{ vendor_id('VendorID') }} as vendor,
        tpep_pickup_datetime as pickup_datetime,
        tpep_dropoff_datetime as dropoff_datetime,	
        passenger_count,
        trip_distance,	
        {{ rate_code_id('RatecodeID') }} as rate_code,
        Store_and_fwd_flag as store_and_forward,
        PULocationID as pickup_location_id, 
        DOLocationID as dropoff_location_id,
        {{ payment_type('payment_type') }} as payment_type,
        fare_amount,
        extra,
        mta_tax, 
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee
    from merged
    where extract(year from tpep_dropoff_datetime) = 2019
)

select * from cleaned