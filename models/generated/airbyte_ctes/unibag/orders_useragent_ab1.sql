{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('useragent', ['ip'], ['ip']) }} as ip,
    {{ json_extract_scalar('useragent', ['version'], ['version']) }} as {{ adapter.quote('version') }},
    {{ json_extract_scalar('useragent', ['platform'], ['platform']) }} as platform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- useragent at orders/userAgent
where 1 = 1
and useragent is not null

