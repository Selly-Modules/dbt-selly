{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_versions_ab3') }}
select
    _id AS id,
    sku AS sku_id,
    {{ adapter.quote('name') }},
    cast({{ adapter.quote('price') }}::json->>'base' AS numeric) AS price_base,
    cast({{ adapter.quote('price') }}::json->>'market' AS numeric) AS price_market,
    cast({{ adapter.quote('price') }}::json->>'minimum' AS numeric) AS price_min,
    cast({{ adapter.quote('price') }}::json->>'maximum' AS numeric) AS price_max,
    cast({{ adapter.quote('price') }}::json->>'supplier' AS numeric) AS price_of_supplier,
    {{ adapter.quote('info') }}::json->'inventory'->>'_id' AS inventory_id,
    cast({{ adapter.quote('info') }}::json->'inventory'->>'id' AS integer) AS inventory_code,
    {{ adapter.quote('info') }}::json->'inventory'->>'name' AS inventory_name,
    {{ adapter.quote('info') }}::json->'supplier'->>'_id' AS supplier_id,
    {{ adapter.quote('info') }}::json->'supplier'->>'name' AS supplier_name,
    {{ adapter.quote('info') }}::json->>'dimension' AS info_dimension,
    cast({{ adapter.quote('info') }}::json->>'weight' AS numeric) AS info_weight,
    cast({{ adapter.quote('statistic') }}::json->>'saleTotal' AS numeric) AS stats_sale_total,
    cast({{ adapter.quote('statistic') }}::json->>'salePending' AS numeric) AS stats_sale_pending,
    cast({{ adapter.quote('statistic') }}::json->>'saleDelivered' AS numeric) AS stats_sale_delivered,
    cast({{ adapter.quote('statistic') }}::json->>'saleCancelled' AS numeric) AS stats_sale_cancelled,
    cast({{ adapter.quote('statistic') }}::json->>'saleCashback' AS numeric) AS stats_sale_cashback,
    product AS product_id,
    version,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_product_sku_versions_hashid
from {{ ref('product_sku_versions_ab3') }}
-- product_sku_versions from {{ source('unibag', '_airbyte_raw_product_sku_versions') }}
where 1 = 1

