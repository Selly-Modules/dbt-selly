{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_versions_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(sku as {{ dbt_utils.type_string() }}) as sku,
    cast(info as {{ dbt_utils.type_string() }}) as info,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(price as {{ dbt_utils.type_string() }}) as price,
    cast({{ adapter.quote('source') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('source') }},
    cast(codesku as {{ dbt_utils.type_string() }}) as codesku,
    cast(picture as {{ dbt_utils.type_string() }}) as picture,
    cast(product as {{ dbt_utils.type_string() }}) as product,
    cast({{ adapter.quote('version') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('version') }},
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions_ab1') }}
-- product_sku_versions
where 1 = 1

