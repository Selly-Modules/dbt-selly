{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('vouchers_ab3') }}
select
    _id,
    code,
    {{ adapter.quote('type') }},
    title,
    active,
    cast({{ adapter.quote('options') }}::json->>'milestones' AS jsonb) AS options_milestones,
    cast({{ adapter.quote('options') }}::json->>'transactionMinValue' AS numeric) AS options_transaction_min_value,
    articleid AS article_id,
    isapplyfororderwholesale AS is_apply_for_order_wholesale,
    startat::timestamp AS start_at,
    endat::timestamp AS end_at,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_vouchers_hashid
from {{ ref('vouchers_ab3') }}
-- vouchers from {{ source('unibag', '_airbyte_raw_vouchers') }}
where 1 = 1

