{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('membership_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    {{ adapter.quote('level') }},
    active,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    {{ adapter.quote('transaction') }} AS order,
    bonuspercent AS bonus_percent,
    transactionminvalue AS order_min_value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_membership_hashid
from {{ ref('membership_ab3') }}
-- membership from {{ source('unibag', '_airbyte_raw_membership') }}
where 1 = 1

