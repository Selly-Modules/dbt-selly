{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('brands_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast(logo as {{ dbt_utils.type_string() }}) as logo,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    {{ cast_to_boolean('active') }} as active,
    photos,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(totalproduct as {{ dbt_utils.type_float() }}) as totalproduct,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('brands_ab1') }}
-- brands
where 1 = 1

