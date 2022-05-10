{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_info_ab1') }}
select
    _airbyte_customers_hashid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(companyname as {{ dbt_utils.type_string() }}) as companyname,
    cast(taxidentificationnumber as {{ dbt_utils.type_string() }}) as taxidentificationnumber,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_info_ab1') }}
-- info at customers/info
where 1 = 1

