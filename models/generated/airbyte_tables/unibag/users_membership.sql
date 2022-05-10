{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_membership_ab3') }}
select
    _airbyte_users_hashid,
    expireat,
    nextlevel,
    currentlevel,
    currenttransactioncount,
    currentsales_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_membership_hashid
from {{ ref('users_membership_ab3') }}
-- membership at users/membership from {{ ref('users') }}
where 1 = 1

