{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('membership_histories_old_statistic_ab3') }}
select
    _airbyte_old_hashid,
    sales,
    {{ adapter.quote('transaction') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('membership_histories_old_statistic_ab3') }}
-- statistic at membership-histories/old/statistic from {{ ref('membership_histories_old') }}
where 1 = 1

