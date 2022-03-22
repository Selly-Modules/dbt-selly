{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotion_orders_ab3') }}
select
    _id,
    {{ adapter.quote('user') }} AS seller_id,
    {{ adapter.quote('order') }} AS order_id,
    promotion AS promotion_id,
    commission,
    status,
    title,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    -- cast({{ adapter.quote('sharepercent') }}::json->>'supplier' AS numeric) AS share_percent_supplier,
    -- cast({{ adapter.quote('sharepercent') }}::json->>'selly' AS numeric) AS share_percent_selly,
    {{ adapter.quote('supplier') }}::json->>'_id' AS supplier_id,
    {{ adapter.quote('supplier') }}::json->>'name' AS supplier_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_promotion_orders_hashid
from {{ ref('promotion_orders_ab3') }}
-- promotion_orders from {{ source('unibag', '_airbyte_raw_promotion_orders') }}
where 1 = 1


