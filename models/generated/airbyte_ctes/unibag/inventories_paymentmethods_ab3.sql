{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('inventories_paymentmethods_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_inventories_hashid',
        boolean_to_string('cod'),
        boolean_to_string('banktransfer'),
    ]) }} as _airbyte_paymentmethods_hashid,
    tmp.*
from {{ ref('inventories_paymentmethods_ab2') }} tmp
-- paymentmethods at inventories/paymentMethods
where 1 = 1

