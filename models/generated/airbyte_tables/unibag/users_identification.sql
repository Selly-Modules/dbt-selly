{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_identification_ab3') }}
select
    _airbyte_users_hashid,
    _id,
    note,
    status,
    timeupdate,
    completedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_identification_hashid
from {{ ref('users_identification_ab3') }}
-- identification at users/identification from {{ ref('users') }}
where 1 = 1

