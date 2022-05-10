{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'cart',
        'note',
        'title',
        object_to_string('request'),
        'service',
        'currency',
        object_to_string('customer'),
        object_to_string('delivery'),
        object_to_string(adapter.quote('location')),
        'createdat',
        object_to_string('promotion'),
        'sessionorder',
        'paymentmethod',
        'estimatetimedelivery',
    ]) }} as _airbyte_session_deliveries_hashid,
    tmp.*
from {{ ref('session_deliveries_ab2') }} tmp
-- session_deliveries
where 1 = 1

