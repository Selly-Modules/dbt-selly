{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('membership_histories_ab3') }}
select
    _id AS id,
    cast({{ adapter.quote('old') }}::json->>'level' AS numeric) AS old_membership_level,
    {{ adapter.quote('old') }}::json->>'name' AS old_membership_name,
    cast({{ adapter.quote('new') }}::json->>'level' AS numeric) AS new_membership_level,
    {{ adapter.quote('new') }}::json->>'name' AS new_membership_name,
    {{ adapter.quote('type') }},
    {{ adapter.quote('user') }} AS seller_id,
    createdat::timestamp AS created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_membership_histories_hashid
from {{ ref('membership_histories_ab3') }}
-- membership_histories from {{ source('unibag', '_airbyte_raw_membership_histories') }}
where 1 = 1

