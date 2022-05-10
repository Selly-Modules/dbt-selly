{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_delivery_weight_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_delivery_hashid',
        adapter.quote('real'),
        'sent',
        'converted',
        'multiplier',
        'convertedwithmultiplier',
    ]) }} as _airbyte_weight_hashid,
    tmp.*
from {{ ref('orders_delivery_weight_ab2') }} tmp
-- weight at orders/delivery/weight
where 1 = 1

