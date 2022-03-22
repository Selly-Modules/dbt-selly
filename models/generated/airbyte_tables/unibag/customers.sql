{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    phone,
    cast({{ adapter.quote('statistic') }}::json->>'expenseTotal' AS numeric) AS stats_expense_total,
    cast({{ adapter.quote('statistic') }}::json->>'transactionTotal' AS numeric) AS stats_order_total,
    cast({{ adapter.quote('statistic') }}::json->>'transactionPending' AS numeric) AS stats_order_pending,
    cast({{ adapter.quote('statistic') }}::json->>'transactionSuccess' AS numeric) AS stats_order_success,
    cast({{ adapter.quote('statistic') }}::json->>'transactionRejected' AS numeric) AS stats_order_rejected,
    {{ adapter.quote('user') }} AS seller_id,
    {{ adapter.quote('location') }}::jsonb,
    createdat::timestamp AS created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customers_hashid
from {{ ref('customers_ab3') }}
-- customers from {{ source('unibag', '_airbyte_raw_customers') }}
where 1 = 1

