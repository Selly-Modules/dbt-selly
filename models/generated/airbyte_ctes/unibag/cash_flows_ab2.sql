{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cash_flows_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(hash as {{ dbt_utils.type_string() }}) as hash,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast({{ adapter.quote('value') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('value') }},
    cast({{ adapter.quote('action') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('action') }},
    cast({{ adapter.quote('options') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('options') }},
    cast(category as {{ dbt_utils.type_string() }}) as category,
    cast(targetid as {{ dbt_utils.type_string() }}) as targetid,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    {{ cast_to_boolean('isaudited') }} as isaudited,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(newbalance as {{ dbt_utils.type_float() }}) as newbalance,
    cast(oldbalance as {{ dbt_utils.type_float() }}) as oldbalance,
    cast(targettype as {{ dbt_utils.type_string() }}) as targettype,
    {{ cast_to_boolean('isprocessed') }} as isprocessed,
    cast(processstatus as {{ dbt_utils.type_string() }}) as processstatus,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cash_flows_ab1') }}
-- cash_flows
where 1 = 1

