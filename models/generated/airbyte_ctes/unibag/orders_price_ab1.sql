{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('price', ['sell'], ['sell']) }} as sell,
    {{ json_extract_scalar('price', ['total'], ['total']) }} as total,
    {{ json_extract_scalar('price', ['market'], ['market']) }} as market,
    {{ json_extract_scalar('price', ['weight'], ['weight']) }} as weight,
    {{ json_extract_scalar('price', ['maximum'], ['maximum']) }} as maximum,
    {{ json_extract_scalar('price', ['minimum'], ['minimum']) }} as minimum,
    {{ json_extract_scalar('price', ['profitUni'], ['profitUni']) }} as profituni,
    {{ json_extract_scalar('price', ['promotion'], ['promotion']) }} as promotion,
    {{ json_extract_scalar('price', ['supplierPrice'], ['supplierPrice']) }} as supplierprice,
    {{ json_extract_scalar('price', ['wholesaleBonus'], ['wholesaleBonus']) }} as wholesalebonus,
    {{ json_extract_scalar('price', ['membershipPercent'], ['membershipPercent']) }} as membershippercent,
    {{ json_extract_scalar('price', ['membershipCommission'], ['membershipCommission']) }} as membershipcommission,
    {{ json_extract_scalar('price', ['base_aibyte_transform'], ['base_aibyte_transform']) }} as base_aibyte_transform,
    {{ json_extract_scalar('price', ['profit_aibyte_transform'], ['profit_aibyte_transform']) }} as profit_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- price at orders/price
where 1 = 1
and price is not null

