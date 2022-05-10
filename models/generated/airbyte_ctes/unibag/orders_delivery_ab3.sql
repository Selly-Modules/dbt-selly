{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_delivery_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        '_id',
        'fee',
        'code',
        'note',
        'title',
        'status',
        object_to_string('weight'),
        object_to_string('feeship'),
        'currency',
        boolean_to_string('freeship'),
        object_to_string(adapter.quote('location')),
        'sourceid',
        'couriername',
        'servicecode',
        'servicename',
        'customername',
        'customerphone',
        'discountvalue',
        'servicedelivery',
        'estimatedeliveryat',
        'estimatetimedelivery',
        'maxdeliveryday_aibyte_transform',
        'mindeliveryday_aibyte_transform',
    ]) }} as _airbyte_delivery_hashid,
    tmp.*
from {{ ref('orders_delivery_ab2') }} tmp
-- delivery at orders/delivery
where 1 = 1

