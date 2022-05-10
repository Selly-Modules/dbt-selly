{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('promotions') }}
select
    _airbyte_promotions_hashid,
    {{ json_extract_scalar('suppliercommission', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('suppliercommission', ['value'], ['value']) }} as {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions') }} as table_alias
-- suppliercommission at promotions/supplierCommission
where 1 = 1
and suppliercommission is not null

