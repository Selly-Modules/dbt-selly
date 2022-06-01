{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_courses_ab3') }}
select
    _id,
    {{ adapter.quote('user') }} AS seller_id,
    course::jsonb,
    hoolaid AS hoola_id,
    academyaccount AS academy_account_id,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_courses_hashid
from {{ ref('user_courses_ab3') }}
-- user_courses from {{ source('unibag', '_airbyte_raw_user_courses') }}
where 1 = 1

