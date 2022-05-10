{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('inventories') }}
select
    _airbyte_inventories_hashid,
    {{ json_extract_scalar('contact', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('contact', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('contact', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('contact', ['address'], ['address']) }} as address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories') }} as table_alias
-- contact at inventories/contact
where 1 = 1
and contact is not null

