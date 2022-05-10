{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_price_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'sell',
        'total',
        'market',
        'weight',
        'maximum',
        'minimum',
        'profituni',
        'promotion',
        'supplierprice',
        'wholesalebonus',
        'membershippercent',
        'membershipcommission',
        'base_aibyte_transform',
        'profit_aibyte_transform',
    ]) }} as _airbyte_price_hashid,
    tmp.*
from {{ ref('orders_price_ab2') }} tmp
-- price at orders/price
where 1 = 1

