{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotions_ab3') }}
select
    _id,
    title,
    type,
    endat::timestamp AS end_at,
    startat::timestamp AS start_at,
    isunlimitedquantity AS is_unlimited_quantity,
    quantity,
    rest,
    {{ adapter.quote('applyfor') }}::json->>'type' AS apply_for_type,
    cast({{ adapter.quote('options') }}::json->>'transactionMinValue' AS numeric) AS options_transaction_min_value,
    cast({{ adapter.quote('options') }}::json->>'milestones' AS jsonb) AS options_milestones,
    {{ adapter.quote('options') }}::json->'bonus'->>'type' AS options_bonus_type,
    cast({{ adapter.quote('options') }}::json->'bonus'->>'value' AS numeric) AS options_bonus_value,
    {{ adapter.quote('conditionforuser') }}::json->>'applyFor' AS condition_for_user_apply_for,
    {{ adapter.quote('conditionforuser') }}::json->>'gender' AS condition_for_user_gender,
    articleid AS article_id,
    isapplyfororderwholesale AS is_apply_for_order_wholesale,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_promotions_hashid
from {{ ref('promotions_ab3') }}
-- promotions from {{ source('unibag', '_airbyte_raw_promotions') }}
where 1 = 1

