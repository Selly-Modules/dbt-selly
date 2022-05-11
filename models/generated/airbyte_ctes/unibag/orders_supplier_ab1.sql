{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('supplier', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('supplier', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('supplier', ['searchString'], ['searchString']) }} as searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- supplier at orders/supplier
where 1 = 1
and supplier is not null
