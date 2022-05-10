{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_request_to_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_to_hashid',
        'address',
        'wardcode',
        'districtcode',
        'provincecode',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('session_deliveries_request_to_location_ab2') }} tmp
-- location at session-deliveries/request/to/location
where 1 = 1

