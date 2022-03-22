{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_order_deliveries') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['delivery'], ['delivery']) }} as delivery,
    {{ json_extract_scalar('_airbyte_data', ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['promotion'], ['promotion']) }} as promotion,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['trackingCode'], ['trackingCode']) }} as trackingcode,
    {{ json_extract_scalar('_airbyte_data', ['trackingTime'], ['trackingTime']) }} as trackingtime,
    {{ json_extract_scalar('_airbyte_data', ['isAdminChange'], ['isAdminChange']) }} as isadminchange,
    {{ json_extract_scalar('_airbyte_data', ['trackingOrderCode'], ['trackingOrderCode']) }} as trackingordercode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_order_deliveries') }} as table_alias
-- order_deliveries
where 1 = 1

