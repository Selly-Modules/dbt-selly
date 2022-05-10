{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotions_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(rest as {{ dbt_utils.type_float() }}) as rest,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(endat as {{ dbt_utils.type_string() }}) as endat,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    {{ cast_to_boolean('active') }} as active,
    cast({{ adapter.quote('options') }} as {{ type_json() }}) as {{ adapter.quote('options') }},
    cast(startat as {{ dbt_utils.type_string() }}) as startat,
    cast(applyfor as {{ type_json() }}) as applyfor,
    cast(quantity as {{ dbt_utils.type_float() }}) as quantity,
    cast(articleid as {{ dbt_utils.type_string() }}) as articleid,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(statistic as {{ type_json() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(conditionforuser as {{ type_json() }}) as conditionforuser,
    cast(suppliercommission as {{ type_json() }}) as suppliercommission,
    {{ cast_to_boolean('isunlimitedquantity') }} as isunlimitedquantity,
    cast(maximumlimitperuser as {{ dbt_utils.type_float() }}) as maximumlimitperuser,
    milestonesstatistic,
    {{ cast_to_boolean('isapplyfororderwholesale') }} as isapplyfororderwholesale,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions_ab1') }}
-- promotions
where 1 = 1

