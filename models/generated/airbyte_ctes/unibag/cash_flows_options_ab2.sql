{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cash_flows_options_ab1') }}
select
    _airbyte_cash_flows_hashid,
    cast(orderid as {{ dbt_utils.type_string() }}) as orderid,
    cast(ordercode as {{ dbt_utils.type_string() }}) as ordercode,
    cast(givegiftid as {{ dbt_utils.type_string() }}) as givegiftid,
    cast(givegifttitle as {{ dbt_utils.type_string() }}) as givegifttitle,
    cast(usergivegiftid as {{ dbt_utils.type_string() }}) as usergivegiftid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cash_flows_options_ab1') }}
-- options at cash-flows/options
where 1 = 1

