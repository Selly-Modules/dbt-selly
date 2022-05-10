{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vouchers_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast(logo as {{ type_json() }}) as logo,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(endat as {{ dbt_utils.type_string() }}) as endat,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    {{ cast_to_boolean('active') }} as active,
    covers,
    cast({{ adapter.quote('options') }} as {{ type_json() }}) as {{ adapter.quote('options') }},
    cast(startat as {{ dbt_utils.type_string() }}) as startat,
    cast(applyfor as {{ type_json() }}) as applyfor,
    cast(articleid as {{ dbt_utils.type_string() }}) as articleid,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    {{ cast_to_boolean('isapplyfororderwholesale') }} as isapplyfororderwholesale,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vouchers_ab1') }}
-- vouchers
where 1 = 1

