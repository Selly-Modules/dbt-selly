{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(tax as {{ dbt_utils.type_string() }}) as tax,
    cast(bank as {{ dbt_utils.type_string() }}) as bank,
    cast(logo as {{ dbt_utils.type_string() }}) as logo,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    {{ cast_to_boolean('active') }} as active,
    cast(checksum as {{ dbt_utils.type_string() }}) as checksum,
    cast(checksum_1 as {{ dbt_utils.type_string() }}) as checksum_1,
    cast({{ adapter.quote('location') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('location') }},
    contracts,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    documents,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    categories,
    inventories,
    cast(identifycode as {{ dbt_utils.type_float() }}) as identifycode,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(contractnumber as {{ dbt_utils.type_string() }}) as contractnumber,
    cast(reviewstatistic as {{ dbt_utils.type_string() }}) as reviewstatistic,
    cast(contractsignedat as {{ dbt_utils.type_string() }}) as contractsignedat,
    emailforinvoices,
    cast(contractexpiredat as {{ dbt_utils.type_string() }}) as contractexpiredat,
    {{ cast_to_boolean('sendinvoicerequesteveryday') }} as sendinvoicerequesteveryday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_ab1') }}
-- suppliers
where 1 = 1

