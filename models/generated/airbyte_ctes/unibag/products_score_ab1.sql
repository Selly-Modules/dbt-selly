{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products') }}
select
    _airbyte_products_hashid,
    {{ json_extract_scalar('score', ['view'], ['view']) }} as {{ adapter.quote('view') }},
    {{ json_extract_scalar('score', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('score', ['profit'], ['profit']) }} as profit,
    {{ json_extract_scalar('score', ['current'], ['current']) }} as {{ adapter.quote('current') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products') }} as table_alias
-- score at products/score
where 1 = 1
and score is not null

