{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_price_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        'base',
        'market',
        'profit',
        'maximum',
        'minimum',
        'supplier',
        'wholesalebonus',
    ]) }} as _airbyte_price_hashid,
    tmp.*
from {{ ref('products_price_ab2') }} tmp
-- price at products/price
where 1 = 1

