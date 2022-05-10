{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_referral_ab3') }}
select
    _airbyte_users_hashid,
    code,
    enabled,
    enabledat,
    sharecontent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_referral_hashid
from {{ ref('users_referral_ab3') }}
-- referral at users/referral from {{ ref('users') }}
where 1 = 1

