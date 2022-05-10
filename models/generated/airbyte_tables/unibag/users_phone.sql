{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_phone_ab3') }}
select
    _airbyte_users_hashid,
    {{ adapter.quote('full') }},
    {{ adapter.quote('number') }},
    verified,
    verifiedat,
    countrycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_hashid
from {{ ref('users_phone_ab3') }}
-- phone at users/phone from {{ ref('users') }}
where 1 = 1

