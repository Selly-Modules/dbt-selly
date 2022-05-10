{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('events_cover_dimensions') }}
select
    _airbyte_dimensions_hashid,
    {{ json_extract_scalar('sm', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('sm', ['width'], ['width']) }} as width,
    {{ json_extract_scalar('sm', ['height'], ['height']) }} as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_cover_dimensions') }} as table_alias
-- sm at events/cover/dimensions/sm
where 1 = 1
and sm is not null

