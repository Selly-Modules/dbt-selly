{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_sku_versions') }}
select
    _airbyte_product_sku_versions_hashid,
    {{ json_extract_scalar('info', ['weight'], ['weight']) }} as weight,
    {{ json_extract('table_alias', 'info', ['category'], ['category']) }} as category,
    {{ json_extract('table_alias', 'info', ['supplier'], ['supplier']) }} as supplier,
    {{ json_extract_scalar('info', ['dimension'], ['dimension']) }} as dimension,
    {{ json_extract('table_alias', 'info', ['inventory'], ['inventory']) }} as inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions') }} as table_alias
-- info at product-sku-versions/info
where 1 = 1
and info is not null

