{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_products') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract_scalar('_airbyte_data', ['info'], ['info']) }} as info,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['temp'], ['temp']) }} as {{ adapter.quote('temp') }},
    {{ json_extract_scalar('_airbyte_data', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['score'], ['score']) }} as score,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['author'], ['author']) }} as author,
    {{ json_extract_array('_airbyte_data', ['guides'], ['guides']) }} as guides,
    {{ json_extract_array('_airbyte_data', ['photos'], ['photos']) }} as photos,
    {{ json_extract_array('_airbyte_data', ['videos'], ['videos']) }} as videos,
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_array('_airbyte_data', ['documents'], ['documents']) }} as documents,
    {{ json_extract_scalar('_airbyte_data', ['shareDesc'], ['shareDesc']) }} as sharedesc,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_array('_airbyte_data', ['categories'], ['categories']) }} as categories,
    {{ json_extract_array('_airbyte_data', ['properties'], ['properties']) }} as properties,
    {{ json_extract_scalar('_airbyte_data', ['reActiveAt'], ['reActiveAt']) }} as reactiveat,
    {{ json_extract_array('_airbyte_data', ['inventories'], ['inventories']) }} as inventories,
    {{ json_extract_scalar('_airbyte_data', ['isOutOfStock'], ['isOutOfStock']) }} as isoutofstock,
    {{ json_extract_scalar('_airbyte_data', ['pricePercent'], ['pricePercent']) }} as pricepercent,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_array('_airbyte_data', ['subCategories'], ['subCategories']) }} as subcategories,
    {{ json_extract_scalar('_airbyte_data', ['inactiveReason'], ['inactiveReason']) }} as inactivereason,
    {{ json_extract_scalar('_airbyte_data', ['propertiesMain'], ['propertiesMain']) }} as propertiesmain,
    {{ json_extract_scalar('_airbyte_data', ['shareStatistic'], ['shareStatistic']) }} as sharestatistic,
    {{ json_extract_scalar('_airbyte_data', ['canIssueInvoice'], ['canIssueInvoice']) }} as canissueinvoice,
    {{ json_extract_scalar('_airbyte_data', ['pendingInactive'], ['pendingInactive']) }} as pendinginactive,
    {{ json_extract_scalar('_airbyte_data', ['reviewStatistic'], ['reviewStatistic']) }} as reviewstatistic,
    {{ json_extract_scalar('_airbyte_data', ['pendingInactiveAt'], ['pendingInactiveAt']) }} as pendinginactiveat,
    {{ json_extract_array('_airbyte_data', ['highlightProperties'], ['highlightProperties']) }} as highlightproperties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_products') }} as table_alias
-- products
where 1 = 1

