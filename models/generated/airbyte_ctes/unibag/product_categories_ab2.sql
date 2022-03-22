{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_categories_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(icon as {{ dbt_utils.type_string() }}) as icon,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(color as {{ dbt_utils.type_string() }}) as color,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('order') }},
    {{ cast_to_boolean('active') }} as active,
    covers,
    {{ cast_to_boolean('featured') }} as featured,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(totalproduct as {{ dbt_utils.type_float() }}) as totalproduct,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_categories_ab1') }}
-- product_categories
where 1 = 1

