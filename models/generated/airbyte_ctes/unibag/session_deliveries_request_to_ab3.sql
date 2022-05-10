{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_request_to_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_request_hashid',
        adapter.quote('name'),
        'phone',
        object_to_string(adapter.quote('location')),
    ]) }} as _airbyte_to_hashid,
    tmp.*
from {{ ref('session_deliveries_request_to_ab2') }} tmp
-- to at session-deliveries/request/to
where 1 = 1

