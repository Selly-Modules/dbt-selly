{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_histories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('order'),
        'status',
        'createdat',
        adapter.quote('timeStamp'),
        'updatedat',
    ]) }} as _airbyte_order_histories_hashid,
    tmp.*
from {{ ref('order_histories_ab2') }} tmp
-- order_histories
where 1 = 1

