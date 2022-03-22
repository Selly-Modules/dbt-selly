{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_suppliers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['tax'], ['tax']) }} as tax,
    {{ json_extract_scalar('_airbyte_data', ['bank'], ['bank']) }} as bank,
    {{ json_extract_scalar('_airbyte_data', ['logo'], ['logo']) }} as logo,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['checkSum'], ['checkSum']) }} as checksum,
    {{ json_extract_scalar('_airbyte_data', ['checksum'], ['checksum']) }} as checksum_1,
    {{ json_extract_scalar('_airbyte_data', ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_array('_airbyte_data', ['contracts'], ['contracts']) }} as contracts,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_array('_airbyte_data', ['documents'], ['documents']) }} as documents,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_array('_airbyte_data', ['categories'], ['categories']) }} as categories,
    {{ json_extract_array('_airbyte_data', ['inventories'], ['inventories']) }} as inventories,
    {{ json_extract_scalar('_airbyte_data', ['identifyCode'], ['identifyCode']) }} as identifycode,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['contractNumber'], ['contractNumber']) }} as contractnumber,
    {{ json_extract_scalar('_airbyte_data', ['reviewStatistic'], ['reviewStatistic']) }} as reviewstatistic,
    {{ json_extract_scalar('_airbyte_data', ['contractSignedAt'], ['contractSignedAt']) }} as contractsignedat,
    {{ json_extract_array('_airbyte_data', ['emailForInvoices'], ['emailForInvoices']) }} as emailforinvoices,
    {{ json_extract_scalar('_airbyte_data', ['contractExpiredAt'], ['contractExpiredAt']) }} as contractexpiredat,
    {{ json_extract_scalar('_airbyte_data', ['sendInvoiceRequestEveryDay'], ['sendInvoiceRequestEveryDay']) }} as sendinvoicerequesteveryday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_suppliers') }} as table_alias
-- suppliers
where 1 = 1

