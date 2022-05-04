{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('voucher_bonus_ab3') }}
select
    _id,
    {{ adapter.quote('user') }} AS seller_id,
    {{ adapter.quote('order') }} AS order_id,
    title,
    status,
    commission,
    isrejected AS is_rejected,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voucher_bonus_hashid
from {{ ref('voucher_bonus_ab3') }}
-- voucher_bonus from {{ source('unibag', '_airbyte_raw_voucher_bonus') }}
where 1 = 1

