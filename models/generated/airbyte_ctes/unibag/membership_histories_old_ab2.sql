{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('membership_histories_old_ab1') }}
select
    _airbyte_membership_histories_hashid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('level') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('level') }},
    cast({{ adapter.quote('condition') }} as {{ type_json() }}) as {{ adapter.quote('condition') }},
    cast(statistic as {{ type_json() }}) as statistic,
    cast({{ adapter.quote('transaction') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('transaction') }},
    cast(bonuspercent as {{ dbt_utils.type_float() }}) as bonuspercent,
    cast(transactionminvalue as {{ dbt_utils.type_float() }}) as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_histories_old_ab1') }}
-- old at membership-histories/old
where 1 = 1

