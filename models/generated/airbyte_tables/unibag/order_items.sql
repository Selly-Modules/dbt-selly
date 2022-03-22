{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_items_ab3') }}
select
    _id AS id,
    status,
    quantity,
    cast({{ adapter.quote('price') }}::json->>'base' AS numeric) AS price_base,
    cast({{ adapter.quote('price') }}::json->>'sell' AS numeric) AS price_sell,
    cast({{ adapter.quote('price') }}::json->>'profit' AS numeric) AS price_profit,
    cast({{ adapter.quote('price') }}::json->>'profitUni' AS numeric) AS price_profit_of_selly,
    cast({{ adapter.quote('price') }}::json->>'wholesaleBonus' AS numeric) AS price_wholesale_bonus,
    cast({{ adapter.quote('price') }}::json->>'sellyWholesaleBonus' AS numeric) AS price_selly_wholesale_bonus,
    cast({{ adapter.quote('price') }}::json->>'minimum' AS numeric) AS price_min,
    cast({{ adapter.quote('price') }}::json->>'maximum' AS numeric) AS price_max,
    cast({{ adapter.quote('price') }}::json->>'market' AS numeric) AS price_market,
    cast({{ adapter.quote('price') }}::json->>'supplierPrice' AS numeric) AS price_of_supplier,
    cast({{ adapter.quote('price') }}::json->>'weight' AS numeric) AS weight,
    {{ adapter.quote('sku') }}::json->>'_id' AS sku_id,
    {{ adapter.quote('sku') }}::json->'version' AS sku_version,
    {{ adapter.quote('sku') }}::json->'unitCode' AS sku_unit_code,
    {{ adapter.quote('user') }} AS seller_id,
    {{ adapter.quote('order') }} AS order_id,
    {{ adapter.quote('product') }} AS product_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_order_items_hashid
from {{ ref('order_items_ab3') }}
-- order_items from {{ source('unibag', '_airbyte_raw_order_items') }}
where 1 = 1

