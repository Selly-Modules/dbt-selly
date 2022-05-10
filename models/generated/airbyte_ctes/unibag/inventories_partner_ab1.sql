{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('inventories') }}
select
    _airbyte_inventories_hashid,
    {{ json_extract_scalar('partner', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('partner', ['identityCode'], ['identityCode']) }} as identitycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories') }} as table_alias
-- partner at inventories/partner
where 1 = 1
and partner is not null

