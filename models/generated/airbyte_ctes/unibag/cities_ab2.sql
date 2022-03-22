{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cities_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_float() }}) as code,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('order') }},
    cast(tncid as {{ dbt_utils.type_float() }}) as tncid,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast({{ adapter.quote('source') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('source') }},
    cast(tempid as {{ dbt_utils.type_float() }}) as tempid,
    cast(tnccode as {{ dbt_utils.type_string() }}) as tnccode,
    cast(osirisid as {{ dbt_utils.type_float() }}) as osirisid,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cities_ab1') }}
-- cities
where 1 = 1

