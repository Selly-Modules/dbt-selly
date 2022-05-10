{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_zalo_ab3') }}
select
    _airbyte_users_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }},
    photo,
    {{ adapter.quote('token') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_zalo_hashid
from {{ ref('users_zalo_ab3') }}
-- zalo at users/zalo from {{ ref('users') }}
where 1 = 1

