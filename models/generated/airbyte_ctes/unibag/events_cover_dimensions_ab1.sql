{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('events_cover') }}
select
    _airbyte_cover_hashid,
    {{ json_extract('table_alias', 'dimensions', ['md'], ['md']) }} as md,
    {{ json_extract('table_alias', 'dimensions', ['sm'], ['sm']) }} as sm,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_cover') }} as table_alias
-- dimensions at events/cover/dimensions
where 1 = 1
and dimensions is not null

