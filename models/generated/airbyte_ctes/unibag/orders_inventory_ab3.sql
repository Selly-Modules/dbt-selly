{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_inventory_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        adapter.quote('id'),
        '_id',
        adapter.quote('name'),
        boolean_to_string('canissueinvoice'),
    ]) }} as _airbyte_inventory_hashid,
    tmp.*
from {{ ref('orders_inventory_ab2') }} tmp
-- inventory at orders/inventory
where 1 = 1

