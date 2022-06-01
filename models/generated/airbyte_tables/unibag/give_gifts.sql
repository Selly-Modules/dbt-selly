{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('give_gifts_ab3') }}
select
    _id,
    title,
    status,
    {{ adapter.quote('content') }},
    createdby AS created_by,
    lastchangeusersat::timestamp AS last_change_users_at,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_give_gifts_hashid
from {{ ref('give_gifts_ab3') }}
-- give_gifts from {{ source('unibag', '_airbyte_raw_give_gifts') }}
where 1 = 1

