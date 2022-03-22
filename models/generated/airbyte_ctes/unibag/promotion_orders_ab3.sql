{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotion_orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        adapter.quote('order'),
        'title',
        'status',
        'supplier',
        'createdat',
        'promotion',
        'updatedat',
        'cashbackat',
        'commission',
        boolean_to_string('isrejected'),
        'quantitypromotion',
    ]) }} as _airbyte_promotion_orders_hashid,
    tmp.*
from {{ ref('promotion_orders_ab2') }} tmp
-- promotion_orders
where 1 = 1

