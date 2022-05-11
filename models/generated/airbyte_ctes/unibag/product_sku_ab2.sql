{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(sku as {{ dbt_utils.type_string() }}) as sku,
    cast(info as {{ dbt_utils.type_string() }}) as info,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(cover as {{ dbt_utils.type_string() }}) as cover,
    cast(price as {{ dbt_utils.type_string() }}) as price,
    {{ cast_to_boolean('active') }} as active,
    cast(author as {{ dbt_utils.type_string() }}) as author,
    cast({{ adapter.quote('source') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('source') }},
    {{ cast_to_boolean('display') }} as display,
    cast(picture as {{ dbt_utils.type_string() }}) as picture,
    cast(product as {{ dbt_utils.type_string() }}) as product,
    cast({{ adapter.quote('version') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('version') }},
    cast(groupsku as {{ dbt_utils.type_string() }}) as groupsku,
    cast(unitcode as {{ dbt_utils.type_string() }}) as unitcode,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(restockat as {{ dbt_utils.type_string() }}) as restockat,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(couponinfo as {{ dbt_utils.type_string() }}) as couponinfo,
    properties,
    {{ cast_to_boolean('canpreorder') }} as canpreorder,
    cast(suppliersku as {{ dbt_utils.type_string() }}) as suppliersku,
    {{ cast_to_boolean('isoutofstock') }} as isoutofstock,
    cast(pricepercent as {{ dbt_utils.type_string() }}) as pricepercent,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    {{ cast_to_boolean('displayinventory') }} as displayinventory,
    {{ cast_to_boolean('showremainingquantity') }} as showremainingquantity,
    cast(quantity as {{ dbt_utils.type_string() }}) as quantity,
    cast(quantity_aibyte_transform as {{ dbt_utils.type_string() }}) as quantity_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_ab1') }}
-- product_sku
where 1 = 1

