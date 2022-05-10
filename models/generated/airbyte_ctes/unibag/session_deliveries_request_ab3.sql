{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_request_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_session_deliveries_hashid',
        object_to_string(adapter.quote('to')),
        object_to_string(adapter.quote('from')),
        array_to_string('items'),
        'checksum',
        'codamount',
        'ordercode',
        'restockat',
        boolean_to_string('ispreorder'),
        'totalamount',
        'paymentmethod',
    ]) }} as _airbyte_request_hashid,
    tmp.*
from {{ ref('session_deliveries_request_ab2') }} tmp
-- request at session-deliveries/request
where 1 = 1

