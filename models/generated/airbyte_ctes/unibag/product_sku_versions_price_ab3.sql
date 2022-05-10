{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_versions_price_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_product_sku_versions_hashid',
        'base',
        'market',
        'maximum',
        'minimum',
        'supplier',
    ]) }} as _airbyte_price_hashid,
    tmp.*
from {{ ref('product_sku_versions_price_ab2') }} tmp
-- price at product-sku-versions/price
where 1 = 1

