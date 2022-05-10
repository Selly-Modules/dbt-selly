{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_email_ab3') }}
select
    _airbyte_users_hashid,
    email,
    verified,
    verifiedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_hashid
from {{ ref('users_email_ab3') }}
-- email at users/email from {{ ref('users') }}
where 1 = 1

