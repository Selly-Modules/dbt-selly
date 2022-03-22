{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'sku',
        adapter.quote('date'),
        adapter.quote('user'),
        'brand',
        adapter.quote('order'),
        'price',
        'status',
        'teamid',
        'product',
        'voucher',
        'customer',
        'quantity',
        'createdat',
        'inventory',
        'totalsell',
        'updatedat',
        'cashbackat',
        array_to_string('promotions'),
        'totalprice',
        'deliveredat',
        'teammemberid',
        boolean_to_string('isassigncoupon'),
        'totalpromotion',
        boolean_to_string('inwholesalerange'),
        'vouchercashtotal',
        'wholesalerangeid',
        'totalwholesalebonus',
        'totalsellywholesalebonus',
    ]) }} as _airbyte_order_items_hashid,
    tmp.*
from {{ ref('order_items_ab2') }} tmp
-- order_items
where 1 = 1

