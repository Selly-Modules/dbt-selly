{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products') }}
select
    _airbyte_products_hashid,
    {{ json_extract_scalar('info', ['profit'], ['profit']) }} as profit,
    {{ json_extract('table_alias', 'info', ['category'], ['category']) }} as category,
    {{ json_extract('table_alias', 'info', ['supplier'], ['supplier']) }} as supplier,
    {{ json_extract('table_alias', 'info', ['inventory'], ['inventory']) }} as inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products') }} as table_alias
-- info at products/info
where 1 = 1
and info is not null

