{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voucher_bonus_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        adapter.quote('order'),
        'title',
        'status',
        'createdat',
        'updatedat',
        'commission',
        boolean_to_string('isrejected'),
        'uservoucher',
    ]) }} as _airbyte_voucher_bonus_hashid,
    tmp.*
from {{ ref('voucher_bonus_ab2') }} tmp
-- voucher_bonus
where 1 = 1

