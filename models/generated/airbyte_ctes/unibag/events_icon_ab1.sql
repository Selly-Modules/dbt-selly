{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('events') }}
select
    _airbyte_events_hashid,
    {{ json_extract_scalar('icon', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('icon', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('table_alias', 'icon', ['dimensions'], ['dimensions']) }} as dimensions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events') }} as table_alias
-- icon at events/icon
where 1 = 1
and icon is not null

