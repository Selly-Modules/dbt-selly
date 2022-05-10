{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotions_statistic_ab1') }}
select
    _airbyte_promotions_hashid,
    cast(nmv as {{ dbt_utils.type_float() }}) as nmv,
    cast(usertotal as {{ dbt_utils.type_float() }}) as usertotal,
    cast(quantitypendingtotal as {{ dbt_utils.type_float() }}) as quantitypendingtotal,
    cast(quantitysuccesstotal as {{ dbt_utils.type_float() }}) as quantitysuccesstotal,
    cast(quantityrejectedtotal as {{ dbt_utils.type_float() }}) as quantityrejectedtotal,
    cast(commissionpendingtotal as {{ dbt_utils.type_float() }}) as commissionpendingtotal,
    cast(commissionsuccesstotal as {{ dbt_utils.type_float() }}) as commissionsuccesstotal,
    cast(commissionrejectedtotal as {{ dbt_utils.type_float() }}) as commissionrejectedtotal,
    cast(quantitynotrejectedtotal as {{ dbt_utils.type_float() }}) as quantitynotrejectedtotal,
    cast(suppliercommissionpending as {{ dbt_utils.type_float() }}) as suppliercommissionpending,
    cast(suppliercommissionsuccess as {{ dbt_utils.type_float() }}) as suppliercommissionsuccess,
    cast(commissionnotrejectedtotal as {{ dbt_utils.type_float() }}) as commissionnotrejectedtotal,
    cast(suppliercommissionnotrejected as {{ dbt_utils.type_float() }}) as suppliercommissionnotrejected,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions_statistic_ab1') }}
-- statistic at promotions/statistic
where 1 = 1

