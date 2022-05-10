{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_items_price_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_items_hashid',
        'base',
        'sell',
        'market',
        'profit',
        'volume',
        'weight',
        'maximum',
        'minimum',
        'profituni',
        'supplierprice',
        'membershippercent',
        'membershipcommission',
    ]) }} as _airbyte_price_hashid,
    tmp.*
from {{ ref('order_items_price_ab2') }} tmp
-- price at order-items/price
where 1 = 1

