{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('membership_histories_old_condition_ab3') }}
select
    _airbyte_old_hashid,
    {{ adapter.quote('name') }},
    sales,
    {{ adapter.quote('transaction') }},
    bonuspercent,
    transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_condition_hashid
from {{ ref('membership_histories_old_condition_ab3') }}
-- condition at membership-histories/old/condition from {{ ref('membership_histories_old') }}
where 1 = 1

