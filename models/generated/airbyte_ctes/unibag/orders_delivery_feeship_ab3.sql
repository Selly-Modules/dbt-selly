{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_delivery_feeship_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_delivery_hashid',
        'cod',
        'total',
        'shipping',
        'insurance',
    ]) }} as _airbyte_feeship_hashid,
    tmp.*
from {{ ref('orders_delivery_feeship_ab2') }} tmp
-- feeship at orders/delivery/feeShip
where 1 = 1

