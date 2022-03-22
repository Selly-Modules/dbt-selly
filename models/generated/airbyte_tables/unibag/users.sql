{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    banned,
    {{ adapter.quote('phone') }}::json->>'full' AS phone_number,
    {{ adapter.quote('phone') }}::json->>'verified' AS phone_verified,
    cast(phone::json->>'verifiedAt' AS date) AS phone_verified_at,
    {{ adapter.quote('info') }}::json->>'email' AS info_email,
    cast({{ adapter.quote('info') }}::json->>'cityCode' AS integer) AS info_province_code,
    {{ adapter.quote('info') }}::json->>'gender' AS info_gender,
    {{ adapter.quote('referral') }}::json->>'code' AS referral_code,
    cast({{ adapter.quote('identification') }}::json->>'completedAt' AS timestamp) AS identification_completed_at,
    {{ adapter.quote('identification') }}::json->>'status' AS identification_status,
    cast({{ adapter.quote('identification') }}::json->>'timeUpdate' AS integer) AS identification_times_update,
    registerfrom AS register_from,
    cast({{ adapter.quote('membership') }}::json->>'currentLevel' AS numeric) AS membership_current_level,
    cast({{ adapter.quote('membership') }}::json->>'expireAt' AS timestamp) AS membership_expire_at,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    lastactivatedat::timestamp AS last_activated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
-- users from {{ source('unibag', '_airbyte_raw_users') }}
where 1 = 1

