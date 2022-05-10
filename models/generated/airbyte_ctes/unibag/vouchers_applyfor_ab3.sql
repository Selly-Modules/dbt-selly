{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vouchers_applyfor_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_vouchers_hashid',
        array_to_string('list'),
        adapter.quote('type'),
        'provinces',
        boolean_to_string('isapplyallorder'),
    ]) }} as _airbyte_applyfor_hashid,
    tmp.*
from {{ ref('vouchers_applyfor_ab2') }} tmp
-- applyfor at vouchers/applyFor
where 1 = 1

