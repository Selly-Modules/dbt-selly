{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('membership_histories_old_statistic_ab1') }}
select
    _airbyte_old_hashid,
    cast(sales as {{ dbt_utils.type_float() }}) as sales,
    cast({{ adapter.quote('transaction') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('transaction') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_histories_old_statistic_ab1') }}
-- statistic at membership-histories/old/statistic
where 1 = 1

