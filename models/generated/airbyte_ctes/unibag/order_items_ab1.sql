{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_order_items') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as {{ adapter.quote('date') }},
    {{ json_extract_scalar('_airbyte_data', ['user'], ['user']) }} as {{ adapter.quote('user') }},
    {{ json_extract_scalar('_airbyte_data', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['teamId'], ['teamId']) }} as teamid,
    {{ json_extract_scalar('_airbyte_data', ['product'], ['product']) }} as product,
    {{ json_extract_scalar('_airbyte_data', ['voucher'], ['voucher']) }} as voucher,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['inventory'], ['inventory']) }} as inventory,
    {{ json_extract_scalar('_airbyte_data', ['totalSell'], ['totalSell']) }} as totalsell,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['cashbackAt'], ['cashbackAt']) }} as cashbackat,
    {{ json_extract_array('_airbyte_data', ['promotions'], ['promotions']) }} as promotions,
    {{ json_extract_scalar('_airbyte_data', ['totalPrice'], ['totalPrice']) }} as totalprice,
    {{ json_extract_scalar('_airbyte_data', ['deliveredAt'], ['deliveredAt']) }} as deliveredat,
    {{ json_extract_scalar('_airbyte_data', ['teamMemberId'], ['teamMemberId']) }} as teammemberid,
    {{ json_extract_scalar('_airbyte_data', ['isAssignCoupon'], ['isAssignCoupon']) }} as isassigncoupon,
    {{ json_extract_scalar('_airbyte_data', ['totalPromotion'], ['totalPromotion']) }} as totalpromotion,
    {{ json_extract_scalar('_airbyte_data', ['inWholesaleRange'], ['inWholesaleRange']) }} as inwholesalerange,
    {{ json_extract_scalar('_airbyte_data', ['voucherCashTotal'], ['voucherCashTotal']) }} as vouchercashtotal,
    {{ json_extract_scalar('_airbyte_data', ['wholesaleRangeId'], ['wholesaleRangeId']) }} as wholesalerangeid,
    {{ json_extract_scalar('_airbyte_data', ['totalWholesaleBonus'], ['totalWholesaleBonus']) }} as totalwholesalebonus,
    {{ json_extract_scalar('_airbyte_data', ['totalSellyWholesaleBonus'], ['totalSellyWholesaleBonus']) }} as totalsellywholesalebonus,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_order_items') }} as table_alias
-- order_items
where 1 = 1

