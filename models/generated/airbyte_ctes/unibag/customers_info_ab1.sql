{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('info', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('info', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('info', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('info', ['companyName'], ['companyName']) }} as companyname,
    {{ json_extract_scalar('info', ['taxIdentificationNumber'], ['taxIdentificationNumber']) }} as taxidentificationnumber,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers') }} as table_alias
-- info at customers/info
where 1 = 1
and info is not null

