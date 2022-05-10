{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('session_deliveries_request') }}
select
    _airbyte_request_hashid,
    {{ json_extract_scalar(adapter.quote('from'), ['userId'], ['userId']) }} as userid,
    {{ json_extract_scalar(adapter.quote('from'), ['warehouseId'], ['warehouseId']) }} as warehouseid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request') }} as table_alias
-- from at session-deliveries/request/from
where 1 = 1
and {{ adapter.quote('from') }} is not null

