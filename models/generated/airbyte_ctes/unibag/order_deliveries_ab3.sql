{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_deliveries_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        adapter.quote('order'),
        'title',
        'status',
        'service',
        'customer',
        'delivery',
        adapter.quote('location'),
        'createdat',
        'promotion',
        'updatedat',
        'trackingcode',
        'trackingtime',
        boolean_to_string('isadminchange'),
        'trackingordercode',
    ]) }} as _airbyte_order_deliveries_hashid,
    tmp.*
from {{ ref('order_deliveries_ab2') }} tmp
-- order_deliveries
where 1 = 1

