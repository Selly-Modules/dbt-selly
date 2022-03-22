{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_product_sku') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['info'], ['info']) }} as info,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('_airbyte_data', ['cover'], ['cover']) }} as cover,
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['author'], ['author']) }} as author,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as {{ adapter.quote('source') }},
    {{ json_extract_scalar('_airbyte_data', ['display'], ['display']) }} as display,
    {{ json_extract_scalar('_airbyte_data', ['picture'], ['picture']) }} as picture,
    {{ json_extract_scalar('_airbyte_data', ['product'], ['product']) }} as product,
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as {{ adapter.quote('version') }},
    {{ json_extract_scalar('_airbyte_data', ['groupSku'], ['groupSku']) }} as groupsku,
    {{ json_extract_scalar('_airbyte_data', ['unitCode'], ['unitCode']) }} as unitcode,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['restockAt'], ['restockAt']) }} as restockat,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['couponInfo'], ['couponInfo']) }} as couponinfo,
    {{ json_extract_array('_airbyte_data', ['properties'], ['properties']) }} as properties,
    {{ json_extract_scalar('_airbyte_data', ['canPreorder'], ['canPreorder']) }} as canpreorder,
    {{ json_extract_scalar('_airbyte_data', ['supplierSku'], ['supplierSku']) }} as suppliersku,
    {{ json_extract_scalar('_airbyte_data', ['isOutOfStock'], ['isOutOfStock']) }} as isoutofstock,
    {{ json_extract_scalar('_airbyte_data', ['pricePercent'], ['pricePercent']) }} as pricepercent,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['displayInventory'], ['displayInventory']) }} as displayinventory,
    {{ json_extract_scalar('_airbyte_data', ['showRemainingQuantity'], ['showRemainingQuantity']) }} as showremainingquantity,
    {{ json_extract_scalar('_airbyte_data', ['quantity_aibyte_transform'], ['quantity_aibyte_transform']) }} as quantity_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_product_sku') }} as table_alias
-- product_sku
where 1 = 1

