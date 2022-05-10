{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_bank_ab1') }}
select
    _airbyte_suppliers_hashid,
    cast(bank as {{ dbt_utils.type_string() }}) as bank,
    cast(branch as {{ dbt_utils.type_string() }}) as branch,
    cast(cardnumber as {{ dbt_utils.type_string() }}) as cardnumber,
    cast(cardholdername as {{ dbt_utils.type_string() }}) as cardholdername,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_bank_ab1') }}
-- bank at suppliers/bank
where 1 = 1

