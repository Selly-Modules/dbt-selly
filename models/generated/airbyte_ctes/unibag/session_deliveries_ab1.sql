{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_session_deliveries') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['cart'], ['cart']) }} as cart,
    {{ json_extract_scalar('_airbyte_data', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract('table_alias', '_airbyte_data', ['request'], ['request']) }} as request,
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', '_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract('table_alias', '_airbyte_data', ['delivery'], ['delivery']) }} as delivery,
    {{ json_extract('table_alias', '_airbyte_data', ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract('table_alias', '_airbyte_data', ['promotion'], ['promotion']) }} as promotion,
    {{ json_extract_scalar('_airbyte_data', ['sessionOrder'], ['sessionOrder']) }} as sessionorder,
    {{ json_extract_scalar('_airbyte_data', ['paymentMethod'], ['paymentMethod']) }} as paymentmethod,
    {{ json_extract_scalar('_airbyte_data', ['estimateTimeDelivery'], ['estimateTimeDelivery']) }} as estimatetimedelivery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_session_deliveries') }} as table_alias
-- session_deliveries
where 1 = 1

