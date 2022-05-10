{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_balance_ab1') }}
select
    _airbyte_suppliers_hashid,
    cast(currentcash as {{ dbt_utils.type_float() }}) as currentcash,
    cast(orderpendingcash as {{ dbt_utils.type_float() }}) as orderpendingcash,
    cast(totalpendingcash as {{ dbt_utils.type_float() }}) as totalpendingcash,
    cast(withdrawrejectcash as {{ dbt_utils.type_float() }}) as withdrawrejectcash,
    cast(orderreconciledcash as {{ dbt_utils.type_float() }}) as orderreconciledcash,
    cast(withdrawpendingcash as {{ dbt_utils.type_float() }}) as withdrawpendingcash,
    cast(withdrawsuccesscash as {{ dbt_utils.type_float() }}) as withdrawsuccesscash,
    cast(changebalancerequestapproved as {{ dbt_utils.type_float() }}) as changebalancerequestapproved,
    cast(orderwaitingforreconcilecash as {{ dbt_utils.type_float() }}) as orderwaitingforreconcilecash,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_balance_ab1') }}
-- balance at suppliers/balance
where 1 = 1

