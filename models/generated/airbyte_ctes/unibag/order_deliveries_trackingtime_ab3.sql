{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_deliveries_trackingtime_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_deliveries_hashid',
        'pickedat',
        'completedat',
        'deliveringat',
    ]) }} as _airbyte_trackingtime_hashid,
    tmp.*
from {{ ref('order_deliveries_trackingtime_ab2') }} tmp
-- trackingtime at order-deliveries/trackingTime
where 1 = 1

