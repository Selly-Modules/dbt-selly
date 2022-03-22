{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('inventories_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_float() }}) as code,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    {{ cast_to_boolean('active') }} as active,
    cast(contact as {{ dbt_utils.type_string() }}) as contact,
    cast(partner as {{ dbt_utils.type_string() }}) as partner,
    cast(checksum as {{ dbt_utils.type_string() }}) as checksum,
    cast({{ adapter.quote('location') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('location') }},
    cast(supplier as {{ dbt_utils.type_string() }}) as supplier,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(minimumvalue as {{ dbt_utils.type_float() }}) as minimumvalue,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(paymentmethods as {{ dbt_utils.type_string() }}) as paymentmethods,
    {{ cast_to_boolean('canissueinvoice') }} as canissueinvoice,
    deliverymethods,
    {{ cast_to_boolean('canautosendemail') }} as canautosendemail,
    cast(invoicedeliverymethod as {{ dbt_utils.type_string() }}) as invoicedeliverymethod,
    {{ cast_to_boolean('doessupportsellyexpress') }} as doessupportsellyexpress,
    prioritydeliveryservicecodes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories_ab1') }}
-- inventories
where 1 = 1

