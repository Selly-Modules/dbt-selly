{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_inventories') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['contact'], ['contact']) }} as contact,
    {{ json_extract_scalar('_airbyte_data', ['partner'], ['partner']) }} as partner,
    {{ json_extract_scalar('_airbyte_data', ['checksum'], ['checksum']) }} as checksum,
    {{ json_extract_scalar('_airbyte_data', ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_scalar('_airbyte_data', ['supplier'], ['supplier']) }} as supplier,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['minimumValue'], ['minimumValue']) }} as minimumvalue,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['paymentMethods'], ['paymentMethods']) }} as paymentmethods,
    {{ json_extract_scalar('_airbyte_data', ['canIssueInvoice'], ['canIssueInvoice']) }} as canissueinvoice,
    {{ json_extract_array('_airbyte_data', ['deliveryMethods'], ['deliveryMethods']) }} as deliverymethods,
    {{ json_extract_scalar('_airbyte_data', ['canAutoSendEmail'], ['canAutoSendEmail']) }} as canautosendemail,
    {{ json_extract_scalar('_airbyte_data', ['invoiceDeliveryMethod'], ['invoiceDeliveryMethod']) }} as invoicedeliverymethod,
    {{ json_extract_scalar('_airbyte_data', ['doesSupportSellyExpress'], ['doesSupportSellyExpress']) }} as doessupportsellyexpress,
    {{ json_extract_array('_airbyte_data', ['priorityDeliveryServiceCodes'], ['priorityDeliveryServiceCodes']) }} as prioritydeliveryservicecodes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_inventories') }} as table_alias
-- inventories
where 1 = 1

