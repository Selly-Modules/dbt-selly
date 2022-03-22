{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_ab3') }}
select
    _id AS id,
    code,
    trackingcode AS tracking_code,
    status,
    banned,
    string_to_array(REPLACE(REPLACE(REPLACE(tags::text, '[', ''), ']', ''), '"', ''), ',') AS tags,
    isdeleted AS is_deleted,
    cast({{ adapter.quote('promotion') }}::json->>'isApplied' AS boolean) AS promotion_is_applied,
    cast({{ adapter.quote('promotion') }}::json->>'discount' AS numeric) AS promotion_discount_value,
    cast({{ adapter.quote('promotion') }}::json->>'minOrderValue' AS numeric) AS promotion_min_order_value,
    {{ adapter.quote('inventory') }}::json->>'_id' AS inventory_id,
    {{ adapter.quote('inventory') }}::json->>'name' AS inventory_name,
    {{ adapter.quote('payment') }}::json->>'method' AS payment_method,
    {{ adapter.quote('payment') }}::json->>'status' AS payment_status,
    cast({{ adapter.quote('price') }}::json->>'base' AS numeric) AS price_base,
    cast({{ adapter.quote('price') }}::json->>'sell' AS numeric) AS price_sell,
    cast({{ adapter.quote('price') }}::json->>'profit' AS numeric) AS price_profit,
    cast({{ adapter.quote('price') }}::json->>'profitUni' AS numeric) AS price_profit_of_selly,
    cast({{ adapter.quote('price') }}::json->>'minimum' AS numeric) AS price_min,
    cast({{ adapter.quote('price') }}::json->>'maximum' AS numeric) AS price_max,
    cast({{ adapter.quote('price') }}::json->>'total' AS numeric) AS price_total,
    cast({{ adapter.quote('price') }}::json->>'weight' AS numeric) AS weight,
    {{ adapter.quote('delivery') }}::json->>'_id' AS delivery_id,
    cast({{ adapter.quote('delivery') }}::json->>'discountValue' AS numeric) AS delivery_discount_value,
    approvedat::timestamp AS approved_at,
    rejectedat::timestamp AS rejected_at,
    pickupat::timestamp AS pickup_at,
    deliveredat::timestamp AS delivered_at,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    {{ adapter.quote('user') }} AS seller_id,
    customer AS customer_id,
    delivery::json->>'status' AS delivery_status,
    iswaitingcancelled AS is_waiting_cancelled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_orders_hashid
from {{ ref('orders_ab3') }}
-- orders from {{ source('unibag', '_airbyte_raw_orders') }}
where 1 = 1

