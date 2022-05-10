{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_items_sku_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_items_hashid',
        '_id',
        'sku',
        adapter.quote('name'),
        adapter.quote('type'),
        adapter.quote('source'),
        'picture',
        adapter.quote('version'),
        array_to_string('properties'),
    ]) }} as _airbyte_sku_hashid,
    tmp.*
from {{ ref('order_items_sku_ab2') }} tmp
-- sku at order-items/sku
where 1 = 1

