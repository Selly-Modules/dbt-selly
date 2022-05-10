{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('vouchers_options_ab3') }}
select
    _airbyte_vouchers_hashid,
    bonus,
    milestones,
    transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_options_hashid
from {{ ref('vouchers_options_ab3') }}
-- options at vouchers/options from {{ ref('vouchers') }}
where 1 = 1

