{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_identifications_ab3') }}
select
    _id,
    dob,
    {{ adapter.quote('name') }},
    {{ adapter.quote('type') }},
    {{ adapter.quote('user') }} AS seller_id,
    gender,
    nation,
    status,
    address,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_identifications_hashid
from {{ ref('user_identifications_ab3') }}
-- user_identifications from {{ source('unibag', '_airbyte_raw_user_identifications') }}
where 1 = 1
