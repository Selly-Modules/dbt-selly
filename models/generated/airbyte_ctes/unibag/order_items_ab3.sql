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
        object_to_string('sku'),
        adapter.quote('date'),
        adapter.quote('user'),
        adapter.quote('order'),
        object_to_string('price'),
        'status',
        'product',
        'customer',
        'quantity',
        'createdat',
        'totalsell',
        'updatedat',
        'cashbackat',
        'totalprice',
        'deliveredat',
    ]) }} as _airbyte_order_items_hashid,
    tmp.*
from {{ ref('order_items_ab2') }} tmp
-- order_items
where 1 = 1

