{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('inventories_paymentmethods_ab1') }}
select
    _airbyte_inventories_hashid,
    {{ cast_to_boolean('cod') }} as cod,
    {{ cast_to_boolean('banktransfer') }} as banktransfer,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories_paymentmethods_ab1') }}
-- paymentmethods at inventories/paymentMethods
where 1 = 1

