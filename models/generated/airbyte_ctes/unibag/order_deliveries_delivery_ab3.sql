{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_deliveries_delivery_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_deliveries_hashid',
        '_id',
        'fee',
        adapter.quote('desc'),
        'note',
        object_to_string('feeship'),
        'currency',
        'couriername',
        'servicecode',
        'servicename',
        'deliverycode',
        'maxdeliverydays',
        'mindeliverydays',
        'estimatetimedelivery',
    ]) }} as _airbyte_delivery_hashid,
    tmp.*
from {{ ref('order_deliveries_delivery_ab2') }} tmp
-- delivery at order-deliveries/delivery
where 1 = 1

