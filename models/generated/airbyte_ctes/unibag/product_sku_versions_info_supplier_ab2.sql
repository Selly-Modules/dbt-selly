{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_versions_info_supplier_ab1') }}
select
    _airbyte_info_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions_info_supplier_ab1') }}
-- supplier at product-sku-versions/info/supplier
where 1 = 1

