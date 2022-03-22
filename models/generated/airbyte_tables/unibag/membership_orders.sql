{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('membership_orders_ab3') }}
select
    _id,
    {{ adapter.quote('user') }} AS seller_id,
    targetid AS target_id,
    membershipPromotion AS membership_promotion,
    membershipname AS membership_name,
    cast(membershiplevel AS integer) AS membership_level,
    cast(commission AS numeric) AS commission,
    status,
    cast({{ adapter.quote('percent') }} AS numeric) AS percent,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    isrejected AS is_rejected,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_membership_orders_hashid
from {{ ref('membership_orders_ab3') }}
-- membership_orders from {{ source('unibag', '_airbyte_raw_membership_orders') }}
where 1 = 1

