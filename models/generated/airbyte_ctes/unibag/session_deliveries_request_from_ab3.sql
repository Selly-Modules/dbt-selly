{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_request_from_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_request_hashid',
        'userid',
        'warehouseid',
    ]) }} as _airbyte_from_hashid,
    tmp.*
from {{ ref('session_deliveries_request_from_ab2') }} tmp
-- from at session-deliveries/request/from
where 1 = 1

