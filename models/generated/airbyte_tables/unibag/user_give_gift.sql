{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_give_gift_ab3') }}
select
    _id,
    {{ adapter.quote('user') }} AS seller_id,
    title,
    givegift AS give_gift_id,
    iscompleted AS is_completed,
    gift::json->>'type' AS gift_type,
    cast(gift::json->>'value' AS numeric) AS gift_value,
    gift::json->>'label' AS gift_label,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_give_gift_hashid
from {{ ref('user_give_gift_ab3') }}
-- user_give_gift from {{ source('unibag', '_airbyte_raw_user_give_gift') }}
where 1 = 1

