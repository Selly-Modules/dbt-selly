{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('vouchers_logo_dimensions') }}
select
    _airbyte_dimensions_hashid,
    {{ json_extract_scalar('md', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('md', ['width'], ['width']) }} as width,
    {{ json_extract_scalar('md', ['height'], ['height']) }} as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vouchers_logo_dimensions') }} as table_alias
-- md at vouchers/logo/dimensions/md
where 1 = 1
and md is not null

