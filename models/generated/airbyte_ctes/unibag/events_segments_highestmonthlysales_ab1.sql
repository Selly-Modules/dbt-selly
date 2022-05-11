{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('events_segments') }}
select
    _airbyte_segments_hashid,
    {{ json_extract_scalar('highestmonthlysales', ['to'], ['to']) }} as {{ adapter.quote('to') }},
    {{ json_extract_scalar('highestmonthlysales', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('highestmonthlysales', ['active'], ['active']) }} as active,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_segments') }} as table_alias
-- highestmonthlysales at events/segments/highestMonthlySales
where 1 = 1
and highestmonthlysales is not null
