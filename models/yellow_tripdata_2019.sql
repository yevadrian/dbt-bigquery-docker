{{ config(materialized='table') }}

with final as (
    select
        tripdata.vendor,
        tripdata.pickup_datetime,
        tripdata.dropoff_datetime,
        pickup.zone as pickup_zone,
        dropoff.zone as dropoff_zone,
        tripdata.passenger_count,
        tripdata.trip_distance,
        tripdata.rate_code,
        tripdata.store_and_forward,
        tripdata.payment_type,
        tripdata.fare_amount,
        tripdata.total_amount
    from {{ ref('stg_yellow_tripdata_2019') }} as tripdata
    left join {{ ref('stg_taxi_zone_lookup') }} as pickup
    on tripdata.pickup_location_id = pickup.location_id
    left join {{ ref('stg_taxi_zone_lookup') }} as dropoff
    on tripdata.dropoff_location_id = dropoff.location_id
    where trip_distance is not null and total_amount is not null
)

select * from final