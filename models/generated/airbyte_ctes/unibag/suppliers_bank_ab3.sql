{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('suppliers_bank_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_suppliers_hashid',
        'bank',
        'branch',
        'cardnumber',
        'cardholdername',
    ]) }} as _airbyte_bank_hashid,
    tmp.*
from {{ ref('suppliers_bank_ab2') }} tmp
-- bank at suppliers/bank
where 1 = 1
