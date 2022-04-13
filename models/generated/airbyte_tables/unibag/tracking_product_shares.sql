{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tracking_product_shares_ab3') }}
select
    _id,
    {{ adapter.quote('source') }},
    {{ adapter.quote('user') }} AS seller_id,
    products AS product_id,
    {{ adapter.quote('options') }}::json->>'action' AS options_action,
    createdat::timestamp AS created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tracking_product_shares_hashid
from {{ ref('tracking_product_shares_ab3') }}
-- tracking_product_shares from {{ source('unibag', '_airbyte_raw_tracking_product_shares') }}
where 1 = 1

