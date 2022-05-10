{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_supplier_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        '_id',
        adapter.quote('name'),
        'searchstring',
    ]) }} as _airbyte_supplier_hashid,
    tmp.*
from {{ ref('orders_supplier_ab2') }} tmp
-- supplier at orders/supplier
where 1 = 1

