{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_ab3') }}
select
    _id,
    sessionorder AS session_order_id,
    title,
    service,
    currency,
    {{ adapter.quote('customer') }}::json->>'_id' AS customer_id,
    {{ adapter.quote('customer') }}::json->>'name' AS customer_name,
    {{ adapter.quote('customer') }}::json->>'phone' AS customer_phone,
    {{ adapter.quote('delivery') }}::jsonb,
    {{ adapter.quote('location') }}::jsonb,
    {{ adapter.quote('promotion') }}::json->>'type' AS promotion_type,
    {{ adapter.quote('promotion') }}::json->>'isApplied' AS promotion_is_applied,
    {{ adapter.quote('promotion') }}::json->>'discount' AS promotion_discount,
    {{ adapter.quote('promotion') }}::json->>'minOrderValue' AS promotion_min_order_value,
    paymentmethod AS payment_method,
    estimatetimedelivery AS estimate_time_delivery,
    createdat::timestamp AS created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_session_deliveries_hashid
from {{ ref('session_deliveries_ab3') }}
-- session_deliveries from {{ source('unibag', '_airbyte_raw_session_deliveries') }}
where 1 = 1

