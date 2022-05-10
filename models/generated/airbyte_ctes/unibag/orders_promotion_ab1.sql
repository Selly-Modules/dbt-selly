{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('promotion', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('promotion', ['discount'], ['discount']) }} as discount,
    {{ json_extract_scalar('promotion', ['isApplied'], ['isApplied']) }} as isapplied,
    {{ json_extract_scalar('promotion', ['minOrderValue'], ['minOrderValue']) }} as minordervalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- promotion at orders/promotion
where 1 = 1
and promotion is not null

