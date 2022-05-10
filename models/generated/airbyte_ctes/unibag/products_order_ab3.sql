{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_order_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        'newest',
        'profit',
        'topsale',
        'scoreyesterday',
        'region_aibyte_transform',
    ]) }} as _airbyte_order_hashid,
    tmp.*
from {{ ref('products_order_ab2') }} tmp
-- order at products/order
where 1 = 1

