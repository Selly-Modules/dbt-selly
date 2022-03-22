{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_ab3') }}
select
    _id AS id,
    title,
    status,
    cast(promotion::json->>'discount' AS numeric) AS discount_value,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->>'fee' AS numeric), 0) AS fee,
    {{ adapter.quote('delivery') }}::json->>'note' AS note,
    {{ adapter.quote('delivery') }}::json->>'courierName' AS courier_name,
    {{ adapter.quote('delivery') }}::json->>'serviceName' AS service_name,
    {{ adapter.quote('delivery') }}::json->>'serviceCode' AS service_code,
    {{ adapter.quote('delivery') }}::json->>'currency' AS currency,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->'feeShip'->>'currency' AS numeric), 0) AS feeship_cod,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->'feeShip'->>'insurance' AS numeric), 0) AS feeship_insurance,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->'feeShip'->>'shipping' AS numeric), 0) AS feeship_shipping,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->'feeShip'->>'total' AS numeric), 0) AS feeship_total,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->>'minDeliveryDay' AS numeric), 0) AS min_delivery_day,
    COALESCE(cast({{ adapter.quote('delivery') }}::json->>'maxDeliveryDay' AS numeric), 0) AS max_delivery_day,
    {{ adapter.quote('delivery') }}::json->>'estimateTimeDelivery' AS estimate_time_delivery,
    service AS service_delivery,
    COALESCE(cast({{ adapter.quote('location') }}::json->>'province' AS integer), 0) AS location_province,
    COALESCE(cast({{ adapter.quote('location') }}::json->>'district' AS integer), 0) AS location_district,
    COALESCE(cast({{ adapter.quote('location') }}::json->>'ward' AS integer), 0) AS location_ward,
    {{ adapter.quote('location') }}::json->>'address' AS location_address,
    {{ adapter.quote('location') }}::json->>'fullAddress' AS location_full_address,
    {{ adapter.quote('customer') }}::json->>'name' AS customer_name,
    {{ adapter.quote('customer') }}::json->>'phone' AS customer_phone,
    {{ adapter.quote('order') }} AS order_id,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_order_deliveries_hashid
from {{ ref('order_deliveries_ab3') }}
-- order_deliveries from {{ source('unibag', '_airbyte_raw_order_deliveries') }}
where 1 = 1

