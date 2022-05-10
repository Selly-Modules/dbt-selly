{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_facebook_ab3') }}
select
    _airbyte_users_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }},
    email,
    photo,
    {{ adapter.quote('token') }},
    gender,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_facebook_hashid
from {{ ref('users_facebook_ab3') }}
-- facebook at users/facebook from {{ ref('users') }}
where 1 = 1

