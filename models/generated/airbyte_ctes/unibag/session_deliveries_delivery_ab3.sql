{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_delivery_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_session_deliveries_hashid',
        '_id',
        'fee',
        adapter.quote('desc'),
        'note',
        'title',
        object_to_string('feeship'),
        'currency',
        'sourceid',
        'couriername',
        'servicecode',
        'servicename',
        'deliverycode',
        'maxdeliverydays',
        'mindeliverydays',
        'realshippingfee',
        'estimatetimedelivery',
    ]) }} as _airbyte_delivery_hashid,
    tmp.*
from {{ ref('session_deliveries_delivery_ab2') }} tmp
-- delivery at session-deliveries/delivery
where 1 = 1

