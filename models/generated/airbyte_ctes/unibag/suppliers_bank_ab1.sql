{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('suppliers') }}
select
    _airbyte_suppliers_hashid,
    {{ json_extract_scalar('bank', ['bank'], ['bank']) }} as bank,
    {{ json_extract_scalar('bank', ['branch'], ['branch']) }} as branch,
    {{ json_extract_scalar('bank', ['cardNumber'], ['cardNumber']) }} as cardnumber,
    {{ json_extract_scalar('bank', ['cardHolderName'], ['cardHolderName']) }} as cardholdername,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers') }} as table_alias
-- bank at suppliers/bank
where 1 = 1
and bank is not null

