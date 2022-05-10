{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('inventories') }}
select
    _airbyte_inventories_hashid,
    {{ json_extract_scalar('paymentmethods', ['cod'], ['cod']) }} as cod,
    {{ json_extract_scalar('paymentmethods', ['bankTransfer'], ['bankTransfer']) }} as banktransfer,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories') }} as table_alias
-- paymentmethods at inventories/paymentMethods
where 1 = 1
and paymentmethods is not null

