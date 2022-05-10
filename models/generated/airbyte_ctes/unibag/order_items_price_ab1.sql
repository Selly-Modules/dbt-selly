{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('order_items') }}
select
    _airbyte_order_items_hashid,
    {{ json_extract_scalar('price', ['base'], ['base']) }} as base,
    {{ json_extract_scalar('price', ['sell'], ['sell']) }} as sell,
    {{ json_extract_scalar('price', ['market'], ['market']) }} as market,
    {{ json_extract_scalar('price', ['profit'], ['profit']) }} as profit,
    {{ json_extract_scalar('price', ['volume'], ['volume']) }} as volume,
    {{ json_extract_scalar('price', ['weight'], ['weight']) }} as weight,
    {{ json_extract_scalar('price', ['maximum'], ['maximum']) }} as maximum,
    {{ json_extract_scalar('price', ['minimum'], ['minimum']) }} as minimum,
    {{ json_extract_scalar('price', ['profitUni'], ['profitUni']) }} as profituni,
    {{ json_extract_scalar('price', ['supplierPrice'], ['supplierPrice']) }} as supplierprice,
    {{ json_extract_scalar('price', ['membershipPercent'], ['membershipPercent']) }} as membershippercent,
    {{ json_extract_scalar('price', ['membershipCommission'], ['membershipCommission']) }} as membershipcommission,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_items') }} as table_alias
-- price at order-items/price
where 1 = 1
and price is not null

