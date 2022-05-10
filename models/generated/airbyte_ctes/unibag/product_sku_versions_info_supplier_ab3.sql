{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_versions_info_supplier_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_info_hashid',
        adapter.quote('id'),
        adapter.quote('name'),
        'searchstring',
    ]) }} as _airbyte_supplier_hashid,
    tmp.*
from {{ ref('product_sku_versions_info_supplier_ab2') }} tmp
-- supplier at product-sku-versions/info/supplier
where 1 = 1

