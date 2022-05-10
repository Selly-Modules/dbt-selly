{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_pricepercent_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_product_sku_hashid',
        'supplier',
        'minimumpricedifferential',
    ]) }} as _airbyte_pricepercent_hashid,
    tmp.*
from {{ ref('product_sku_pricepercent_ab2') }} tmp
-- pricepercent at product-sku/pricePercent
where 1 = 1

